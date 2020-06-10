class RolifyCreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :name
      t.references :resource, :polymorphic => true, type: :uuid

      t.timestamps
    end

    create_table :users_roles, id: :uuid, default: "gen_random_uuid()" do |t|
      t.references :user, type: :uuid
      t.references :role, type: :uuid
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
    # , unique: true
  end
end
