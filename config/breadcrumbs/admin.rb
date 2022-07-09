crumb :admin do
  link "Admin", admin_dashboard_path
  parent :root
end

### Users

crumb :admin_users do
  link "Users", admin_users_path
  parent :admin
end

crumb :admin_user do |user|
  link user.to_s, admin_user_path(user)
  parent :admin_users
end

crumb :admin_user_logs do |user|
  link "Logs", admin_user_login_activities_path(user)
  parent :admin_user, user
end

crumb :admin_user_log_entry do |entry|
  link local_time(entry.created_at), admin_login_activity_path(entry)
  parent :admin_user_logs, entry.user
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