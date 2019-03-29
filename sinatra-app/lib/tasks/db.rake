namespace :db do
  desc 'Create database'
  task :create do |_, args|
    db = App.db
    db.execute "DROP DATABASE IF EXISTS sinatra_app_development"
    db.execute "CREATE DATABASE sinatra_app_development"
  end

  desc 'Create migration file'
  task :create_migration, [:name] do |_, args|
    timestamp = Time.new.strftime('%Y%m%d%H%M%S')
    migration_dir = File.expand_path('../../../db/migrations', __FILE__)
    migration_path = "#{migration_dir}/#{timestamp}_#{args[:name]}.rb"
    File.write(migration_path, "Sequel.migration do\nend")
    puts "Migration #{migration_path} created"
  end

  desc 'Create or update schema.rb'
  task :dump_schema do |_, _|
    db = App.db
    db.extension(:schema_dumper)
    schema = db.dump_schema_migration(same_db: true)
    begin
      file = File.open(File.expand_path('../../db/schema.rb', __dir__), 'w+')
      file.write schema
    rescue IOError => e
      puts "Cannot create or update schema.rb : #{e.message}"
    ensure
      file.close unless file.nil?
    end
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration
    db = App.db

    # Run migrations
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(
        db, 'db/migrations', target: args[:version].to_i
      )
    else
      Sequel::Migrator.run(db, 'db/migrations')
      puts 'Migrated to latest'
    end

    Rake::Task['db:dump_schema'].execute
  end

  desc 'Rollback to a specific target (timestamp version)'
  task :rollback, :target do |t, args|
    Sequel.extension :migration

    db = App.db
    if args[:target]
      Sequel::Migrator.run(db, 'db/migrations', target: args[:target].to_i)
      Rake::Task['db:dump_schema'].execute
    else
      puts "Error: missing target version..."
    end
  end
end
