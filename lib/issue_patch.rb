require_dependency 'issue'

module IssuePatch
	def self.included(base) # :nodoc:
		base.send(:include, InstanceMethods)

		# Same as typing in the class 
		base.class_eval do
			unloadable
			belongs_to :filed_version, :class_name => 'Version', :foreign_key => 'filed_version_id'
			safe_attributes 'filed_version_id'

		end

	end

	module InstanceMethods
		# Wraps the association to get the Deliverable subject.  Needed for the 
		# Query and filtering
		# def filed_version
		#   return self.filed_version
		# end
	end
end

Issue.send :include, IssuePatch
