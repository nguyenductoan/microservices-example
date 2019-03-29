require 'sequel'
require 'json'

module App
  def self.db
    connection_info = {
      adapter: ENV['DATABASE_ADAPTER'] || 'postgres',
      host: ENV['DATABASE_HOST'] || 'localhost',
      port: ENV['DATABASE_PORT'] || '5432',
      database: ENV['DATABASE_NAME'] || 'postgres',
      max_connections: ENV['DATABASE_CONNECTION'] || 4
    }
    db = Sequel.connect(connection_info)
    db.extension(:connection_validator)
    db.extension(:pg_json)
    db.extension(:pg_enum)
  end
end

require_relative 'sidekiq_config'

# models
Dir[File.expand_path('../../models/*.rb', __FILE__)].each { |f| require f }
# workers
Dir[File.expand_path('../../workers/*.rb', __FILE__)].each { |f| require f }
# controllers
Dir[File.expand_path('../../controllers/*.rb', __FILE__)].each { |f| require f }

# start console
# - irb
# - require_relative 'config/environment'
# start sidekiq
# - bundle exec sidekiq -C "./config/sidekiq.yml" "-r" "./config/environment.rb"

