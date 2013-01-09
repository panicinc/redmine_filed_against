require_dependency 'project'

module ProjectPatch
	def self.included(base) # :nodoc:
		base.send(:include, InstanceMethods)

		# Same as typing in the class 
		base.class_eval do
			unloadable
		  belongs_to :default_version, :class_name => 'Version', :foreign_key => 'default_version_id'
			safe_attributes 'default_version_id'

		end

	end

	module InstanceMethods
		def default_version_id=(vid)
	    self.default_version = nil
	    write_attribute(:default_version_id, vid)
	  end
	  
	end
end

Project.send :include, ProjectPatch
