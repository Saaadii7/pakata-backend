class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :datetime
    add_column :users, :gender, :integer
    add_column :users, :deleted_at, :datetime

    add_index :users, :user_name
    add_index :users, :deleted_at
  end
end
