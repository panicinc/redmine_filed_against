require_dependency 'issues_helper'

module IssueHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :show_detail, :filed_version
    end
  end

  module InstanceMethods

		def show_detail_with_filed_version(detail, no_html=false, options={})
			
			if detail.property == 'attr' && detail.prop_key == "filed_version_id"
	      field = detail.prop_key.to_s.gsub(/\_id$/, "")
	      label = l(("field_" + field).to_sym)

				value = find_name_by_reflection(field, detail.value)
        old_value = find_name_by_reflection(field, detail.old_value)

		    call_hook(:helper_issues_show_detail_after_setting,
		              {:detail => detail, :label => label, :value => value, :old_value => old_value })

				unless no_html
				  label = content_tag('strong', label)
				  old_value = content_tag("i", h(old_value)) if detail.old_value
				  old_value = content_tag("strike", old_value) if detail.old_value and detail.value.blank?
				  if detail.property == 'attachment' && !value.blank? && atta = Attachment.find_by_id(detail.prop_key)
				    # Link to the attachment if it has not been removed
				    value = link_to_attachment(atta, :download => true, :only_path => options[:only_path])
				    if options[:only_path] != false && atta.is_text?
				      value += link_to(
				                   image_tag('magnifier.png'),
				                   :controller => 'attachments', :action => 'show',
				                   :id => atta, :filename => atta.filename
				                 )
				    end
				  else
				    value = content_tag("i", h(value)) if value
				  end
				end

	    	if detail.value.present?
		      case detail.property
		      when 'attr', 'cf'
		        if detail.old_value.present?
		          l(:text_journal_changed, :label => label, :old => old_value, :new => value).html_safe
		        elsif multiple
		          l(:text_journal_added, :label => label, :value => value).html_safe
		        else
		          l(:text_journal_set_to, :label => label, :value => value).html_safe
		        end
		      end
		    else
		      l(:text_journal_deleted, :label => label, :old => old_value).html_safe
		    end



      else
				show_detail(detail, no_html, options)
			end
		end
	end
end

IssuesHelper.send(:include, IssueHelperPatch)
