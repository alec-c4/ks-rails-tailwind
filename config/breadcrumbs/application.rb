crumb :root do
  link "Home", root_path
end

### Pages

crumb :privacy_policy do
  link "Privacy Policy", privacy_path
end

crumb :terms do
  link "Terms of service", terms_path
end

crumb :about do
  link "About us", about_path
end

### Users

crumb :profile do
  link "Profile", profile_path
end

crumb :account do
  link "Account", edit_user_registration_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).