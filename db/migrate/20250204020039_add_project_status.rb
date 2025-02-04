class AddProjectStatus < ActiveRecord::Migration[7.2]
  def up
    create_enum :project_status, ["Pending", "Active", "Archived"]
    add_column :projects, :status, :project_status, default: "Pending", null: false
  end

  def down
    remove_column :projects, :status
    execute <<-SQL
      DROP TYPE project_status;
    SQL
  end
end
