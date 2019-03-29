Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:trackings) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :keyword, "text"
      column :request_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
    
    create_table(:users) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :email, "text"
      column :name, "text"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
  end
end
