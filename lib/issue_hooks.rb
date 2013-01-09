module FiledAgainstIssue
  module Hooks
    class IssueHooks < Redmine::Hook::ViewListener

      render_on(:view_issues_show_details_bottom, :partial => 'hooks/view_issue', :layout => false)
      render_on(:edit_issues_fields_left, :partial => 'hooks/edit_issue_filed_against', :layout => false)

    end
  end
end
