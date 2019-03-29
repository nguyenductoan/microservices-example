Sequel.migration do
  up do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'
    create_table :trackings do
      column :id, :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :keyword, String
      column :request_at, Time
      column :created_at, Time, default: Sequel.function(:now)
    end
  end

  down do
    drop_table :trackings
  end
end
