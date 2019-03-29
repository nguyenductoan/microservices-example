Sequel.migration do
  up do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'
    create_table :users do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :email, String
      column :name, String
      column :created_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :users
  end
end
