require_dependency 'project'

module VersionPatch
	def self.included(base) # :nodoc:

		base.class_eval do
			unloadable
		  has_many :filed_version, :class_name => 'Issue', :foreign_key => 'filed_version_id'
		  has_many :default_version, :class_name => 'Project', :foreign_key => 'default_version_id'

		end

	end
end

Version.send :include, VersionPatch
