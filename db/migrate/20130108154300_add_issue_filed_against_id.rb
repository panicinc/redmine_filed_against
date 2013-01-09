class AddIssueFiledAgainstId < ActiveRecord::Migration
  def self.up
    add_column :issues, :filed_version_id, :integer
    add_column :projects, :default_version_id, :integer, :default => nil
  end

  def self.down
    remove_column :issues, :filed_version_id
    remove_column :projects, :default_version_id
  end
end
