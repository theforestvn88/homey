class AddChecksumToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :checksum, :string
    add_index :comments, [:user_id, :checksum], unique: true
  end
end
