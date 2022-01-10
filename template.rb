require "rails/all"
require "fileutils"
require "shellwords"

RAILS_REQUIREMENT = ">= 7.0.0"
REPO_LINK = "https://github.com/alec-c4/ks-rails-tailwind.git"

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path

  # setup vscode
  copy_file ".editorconfig", force: true
  directory ".vscode", force: true

  # setup .gitignore 
  copy_file ".gitignore", force: true

  # setup Makefile
  copy_file "Makefile", force: true

  # setup Gemfile
  template "Gemfile.tt", force: true

  # setup lefthook
  copy_file "lefthook.yml", force: true

  after_bundle do
    apply_app_changes
    show_post_install_message
  end
end

def apply_app_changes
  # setup generators
  copy_file "config/initializers/generators.rb", force: true

  # setup Procfile
  copy_file "Procfile.dev", force: true

  # setup frontend with timezone support
  run "yarn add jstz local-time"
  run "yarn add @tailwindcss/forms tailwindcss-font-inter"
  directory "app/javascript", force: true
  copy_file "tailwind.config.js", force: true
  copy_file ".erb-lint.yml", force: true

  # setup_sidekiq
  copy_file "config/initializers/sidekiq.rb", force: true
  copy_file "config/sidekiq.yml", force: true

  # setup main configuration

  generate "config:install -s"
  directory "config/settings", force: true

  generate "meta_tags:install"

  rails_command "sitemap:install"

  generate "annotate:install"

  generate "simple_form:install"

  generate "strong_migrations:install"

  generate "hypershield:install"

  copy_file "config/initializers/pagy.rb", force: true

  inject_into_file "config/application.rb", after: /config\.generators\.system_tests = nil\n/ do
    <<-'RUBY'
     # use custom error pages
     config.exceptions_app = routes

     # disable remote forms generation
     config.action_view.form_with_generates_remote_forms = false
    RUBY
  end

  inject_into_file "config/environments/development.rb",
                   after: /config\.action_cable\.disable_request_forgery_protection = true\n/ do
    <<-'RUBY'
    # Mail
    config.action_mailer.delivery_method = :letter_opener_web
    config.action_mailer.default_url_options = {
      host: Settings.mailer.default_url.host,
      port: Settings.mailer.default_url.port,
      protocol: Settings.mailer.default_url.protocol
    }
    config.action_mailer.perform_deliveries = true

    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

    # Bullet
    config.after_initialize do
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
      # Bullet.growl         = true
      Bullet.rails_logger = true
      Bullet.add_footer = true
    end

    # Identity cache
    config.identity_cache_store = :mem_cache_store, "localhost", {
      expires_in: 6.hours.to_i, # in case of network errors when sending a cache invalidation
      failover: false # avoids more cache consistency issues
    }    

    # Uncomment if you need to test custom error pages
    # config.consider_all_requests_local = false
    RUBY
  end

  inject_into_file "config/environments/test.rb",
                   after: /config\.action_view\.annotate_rendered_view_with_filenames = true\n/ do
    <<-'RUBY'
    # Bullet
    config.after_initialize do
      Bullet.enable = true
      Bullet.bullet_logger = true
      Bullet.raise = true # raise an error if n+1 query occurs
    end

    # Mailer
    config.action_mailer.default_url_options = {
      host: Settings.mailer.default_url.host,
      port: Settings.mailer.default_url.port,
      protocol: Settings.mailer.default_url.protocol
    }
    RUBY
  end

  inject_into_file "config/environments/production.rb",
                   after: /config\.active_record\.dump_schema_after_migration = false\n/ do
    <<-'RUBY'
    # Mail
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = {
      api_token: Rails.application.credentials.postmark[:api_key]
    }
    config.action_mailer.default_url_options = {
      host: Settings.mailer.default_url.host,
      protocol: Settings.mailer.default_url.protocol
    }
    config.action_mailer.perform_deliveries = true

    # Identity cache
    config.identity_cache_store = :mem_cache_store, "localhost", {
      expires_in: 6.hours.to_i, # in case of network errors when sending a cache invalidation
      failover: false # avoids more cache consistency issues
    }        
    RUBY
  end

  gsub_file "config/environments/production.rb", /STDOUT/, "$stdout"
  gsub_file "config/puma.rb", /fetch("RAILS_MAX_THREADS") { 5 }/, 'fetch("RAILS_MAX_THREADS", 5)'
  gsub_file "config/puma.rb", /fetch("PORT") { 3000 }/, 'fetch("PORT", 3000)'

  run "cp config/environments/production.rb config/environments/staging.rb"

  # setup migrations

  generate "migration EnableUuidPsqlExtension"
  uuid_migration_file = (Dir["db/migrate/*_enable_uuid_psql_extension.rb"]).first
  copy_file "migrations/uuid.rb", uuid_migration_file, force: true

  generate "migration EnableTrgmPsqlExtension"
  trgm_migration_file = (Dir["db/migrate/*_enable_trgm_psql_extension.rb"]).first
  copy_file "migrations/trgm.rb", trgm_migration_file, force: true
  generate "pg_search:migration:multisearch"

  rails_command "active_storage:install"
  as_migration_file = (Dir["db/migrate/*_create_active_storage_tables.active_storage.rb"]).first
  copy_file "migrations/active_storage.rb", as_migration_file, force: true

  generate "friendly_id"
  friendly_id_migration_file = (Dir["db/migrate/*_create_friendly_id_slugs.rb"]).first
  copy_file "migrations/friendly_id.rb", friendly_id_migration_file, force: true

  # setup auth
  generate "devise:install"
  generate "migration devise_create_users"
  generate "migration create_identities"
  generate "migration rolify_create_roles"
  copy_file "config/initializers/rolify.rb", force: true
  generate "authtrail:install --encryption=activerecord"

  devise_migration_file = (Dir["db/migrate/*_devise_create_users.rb"]).first
  copy_file "migrations/create_users.rb", devise_migration_file, force: true

  identity_migration_file = (Dir["db/migrate/*_create_identities.rb"]).first
  copy_file "migrations/create_identities.rb", identity_migration_file, force: true

  rolify_migration_file = (Dir["db/migrate/*_rolify_create_roles.rb"]).first
  copy_file "migrations/rolify.rb", rolify_migration_file, force: true

  authrail_migration_file = (Dir["db/migrate/*_create_login_activities.rb"]).first
  copy_file "migrations/authrail.rb", authrail_migration_file, force: true

  # setup i18n
  copy_file "config/initializers/i18n.rb", force: true
  directory "config/locales", force: true
  copy_file "config/i18n-tasks.yml", force: true

  # setup Mailkick
  generate "mailkick:install"
  mailkick_migration_file = (Dir["db/migrate/*_create_mailkick_subscriptions.rb"]).first
  copy_file "migrations/mailkick.rb", mailkick_migration_file, force: true

  # setup noticed
  generate "noticed:model"
  noticed_migration_file = (Dir["db/migrate/*_create_notifications.rb"]).first
  copy_file "migrations/noticed.rb", noticed_migration_file, force: true

  # setup ahoy and blazer
  generate "ahoy:install"
  generate "blazer:install"

  ahoy_migration_file = (Dir["db/migrate/*_create_ahoy_visits_and_events.rb"]).first
  copy_file "migrations/ahoy.rb", ahoy_migration_file, force: true

  blazer_migration_file = (Dir["db/migrate/*_install_blazer.rb"]).first
  copy_file "migrations/blazer.rb", blazer_migration_file, force: true

  # setup application logic

  directory "app/controllers", force: true
  directory "app/components", force: true
  directory "app/helpers", force: true
  directory "app/jobs", force: true
  directory "app/mailers", force: true
  directory "app/models", force: true
  directory "app/views", force: true
  directory "app/policies", force: true
  copy_file "app/assets/stylesheets/application.tailwind.css", force: true
  copy_file "config/routes.rb", force: true
  copy_file "config/puma.rb", force: true

  # setup specs
  generate "rspec:install"
  directory "spec", force: true
  copy_file ".rspec", force: true

  # setup hypershield gem
  generate "hypershield:install"

  copy_file "config/initializers/devise.rb", force: true

  copy_file "public/robots.txt", force: true

  # run linters
  run "i18n-tasks normalize"
  run "bundle exec erblint --lint-all -a"
  run "standard --fix"
  run "standardrb --fix"
end

def show_post_install_message
  say "\n
  #########################################################################################

  App successfully created!\n

  Next steps:
  1 - add creadentials as described in README.md
  2 - configure database connections
  3 - configure application options in config/settings
  4 - run following command \n
  git init && git add . &&  git commit -am 'Initial import' && lefthook install \n
  
  #########################################################################################\n", :green
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

def add_template_repository_to_source_path
  if __FILE__.match?(%r{\Ahttps?://})
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("kickstart-tmp"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      REPO_LINK,
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{kickstart/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d.\w'"]*)?.*$/, 1]
  req && req.tr("'", %(")).strip.sub(/^,\s*"/, ', "')
end

run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"
apply_template!