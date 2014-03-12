class StudentsAddAdminFlag < ActiveRecord::Migration
  def change
    add_column :students, :is_admin, :boolean
  end
end
