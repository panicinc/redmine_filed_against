module FiledAgainstProject
  module Hooks
    class ProjectHooks < Redmine::Hook::ViewListener

      render_on(:view_projects_form, :partial => 'hooks/view_projects_form', :layout => false)

    end
  end
end
