# Kickstart rails app template (tailwind.css version)

## Usage

1. Install 
- PostgreSQL database
- Redis key-value server
- Memcached server
- Node.js
- yarn
- ruby using rbenv
- ruby on rails using `gem install rails`

2. Create app using template

```bash
rails new APP_NAME --no-skip-hotwire -T -c tailwind -j esbuild -d postgresql -m https://raw.githubusercontent.com/alec-c4/ks-rails-tailwind/master/template.rb
```

3. Create all required accounts:

- [Digital Ocean](https://m.do.co/c/cfc852e7f0e6) or [Linode](https://www.linode.com/?r=163287613c0644b17ccd5aad43f40bdf9b0b0e2f)
- [Appsignal](https://appsignal.com/r/53a0242a45)
- [Postmark](https://postmarkapp.com)
- Register keys for Google authentication in [Google API console](https://console.cloud.google.com/apis/)

4. Configure Appsignal with `bundle exec appsignal install APPSIGNAL_KEY`

5. Setup hypershield gem for [PostgreSQL](https://github.com/ankane/hypershield#postgres) and create user for [blazer gem](https://github.com/ankane/blazer#permissions)

6. Configure sitemap generator in `config/sitemap.rb`

7. Configure application secrets with following template

```yaml
active_record_encryption:
  primary_key: ''
  deterministic_key: ''
  key_derivation_salt: ''
secret_key_base: ''
devise:
  secret_key: ''
google:
  client_id: ''
  client_secret: ''
postmark:
  api_key: ''
```

You can generate active record encryption keys with following command

```bash
bin/rails db:encryption:init
```

8. Configure application in  `config/settings.yml`

9. Configure rack-attack using following [guide](https://expeditedsecurity.com/blog/ultimate-guide-to-rack-attack/)

10. Add [legal documents](https://github.com/ankane/awesome-legal).

11. Update error pages in `app/views/errors/*` with your content 

12. Update `config/database.yml`  -  just change configuration line for development from

```yml
development:
  <<: *default
  database: APP_NAME_development
```

to

```yml
development:
  <<: *default
  database: <%= ENV['CYPRESS'] ? 'APP_NAME_test' : 'APP_NAME_development' %>
```

Example configuration is available in `config/database.yml.example`

## What's inside

- ruby on rails application template 
- .gitignore file
- [VSCode](https://code.visualstudio.com/) configuration files
- postgresql database connector
- timezone detection with [jstz](https://github.com/iansinnott/jstz)
- [Good Job](https://github.com/bensheldon/good_job) for background jobs
- [strong_migrations](https://github.com/ankane/strong_migrations)
- authentication with [devise](https://github.com/heartcombo/devise) and [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password) + google auth
- [pretender](https://github.com/ankane/pretender)
- authorization with [pundit](https://github.com/varvet/pundit) + [pundit-matchers](https://github.com/chrisalley/pundit-matchers) for tests
- role management with [rolify](https://github.com/RolifyCommunity/rolify)
- ability to ban user account
- pre-configured generators
- SEO tools - [meta-tags](https://github.com/kpumuk/meta-tags), [sitemap_generator](http://github.com/kjvarga/sitemap_generator) and [friendly_id](https://github.com/norman/friendly_id)
- I18n tools - [rails-i18n](http://github.com/svenfuchs/rails-i18n) and [i18n-tasks](https://github.com/glebm/i18n-tasks)
- [rspec](https://rspec.info) and [cypress](https://cypress.io) for testing
- [better_html](https://github.com/Shopify/better-html) and [erb-lint](https://github.com/Shopify/erb-lint) for erb linting
- [standard.js](https://standardjs.com) and [standard.rb](https://github.com/testdouble/standard) for code style validations
- [bullet](https://github.com/flyerhzm/bullet) to prevent N+1 problems
- [brakeman](https://github.com/presidentbeef/brakeman) and [bundler-audit](https://github.com/postmodern/bundler-audit) as security scanners
- [pry-rails](https://github.com/rweng/pry-rails) and [amazing_print](https://github.com/amazing-print/amazing_print) for better rails console
- [view_component](https://viewcomponent.org/) as a replacement for partials
- [ahoy](https://github.com/ankane/ahoy), [ahoy_email](https://github.com/ankane/ahoy_email) and [blazer](https://github.com/ankane/blazer) for business intelligence
- [noticed](https://github.com/excid3/noticed) for notifications
- [annotate](https://github.com/ctran/annotate_models) for annotations
- [rack-attack](https://github.com/rack/rack-attack) to prevent bruteforce and DDoS attacks 
- [authrail](https://github.com/ankane/authtrail) to track login attempts
- [lefthook](https://github.com/evilmartians/lefthook) with pre-commit run of rspec, brakeman, standardjs, standardrb and erblint
- [semantic_logger](https://github.com/reidmorrison/semantic_logger) as a highly configurable logging system
- [simplecov](https://github.com/simplecov-ruby/simplecov) for test coverage research
- [mailkick](https://github.com/ankane/mailkick)
- [discard](https://github.com/jhawthorn/discard)
- [hypershield](https://github.com/ankane/hypershield)
- [identity_cache](https://github.com/Shopify/identity_cache)
- [active_storage_validations](https://github.com/igorkasyanchuk/active_storage_validations)
- [avatarly](https://github.com/lucek/avatarly) for default avatar generation
- [rails_performance](https://github.com/igorkasyanchuk/rails_performance)
- landing page
- custom error pages
- profiles controller
- admin and customer dashboards
- users administration with search

## TODO

- add announcements (new/fix/update) for all users
- add feedback
- add 2FA for all users and enabled for admin accounts by default
- add monitoring and analytics tools
- add A11y
- add deployments tools
- add documentation (howto's, best practices, curated list of libraries)
