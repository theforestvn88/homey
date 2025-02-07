class AddChangeableToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :changeable, :boolean, default: true
  end
end
