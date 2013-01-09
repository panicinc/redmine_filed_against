require_dependency 'query'

module QueryPatch

	def self.included(base)
		base.send(:include, InstanceMethods)

		base.class_eval do
			unloadable
			base.add_available_column(QueryColumn.new(:filed_version, :sortable => ["#{Version.table_name}.effective_date", "#{Version.table_name}.name"], :default_order => 'desc', :groupable => true))

			alias_method :redmine_available_filters, :available_filters
			alias_method :available_filters, :filed_available_filters
		end
	end


	module InstanceMethods

		# Wrapper around the +available_filters+ to add a new Deliverable filter
		def filed_available_filters
			@available_filters = redmine_available_filters
			filed_filters = { }

			if project

				versions = project.shared_versions.all
				unless versions.empty?
					filed_filters = { "filed_version_id" => { :type => :list_optional, :order => 7, :values => versions.sort.collect{|s| ["#{s.project.name} - #{s.name}", s.id.to_s] } }}
				end

			end
			return @available_filters.merge(filed_filters)
		end
	end
end

Query.send :include, QueryPatch
