require File.expand_path('../../../sample_service', __FILE__)

require File.expand_path('../../../app/grpc/base_handler', __FILE__)
Dir[File.expand_path('../../../app/grpc/*.rb', __FILE__)].each { |file| require file }


EhProtobuf.config_server(
  SampleService,
  host: ENV['EH_RPC_HOST'] || 'localhost',
  port: ENV['EH_RPC_PORT'] || 50_051,
  pool_size: (ENV['EH_RPC_POOL_SIZE'] || 15).to_i,
  logger: Logger.new(STDOUT).tap do |logger|
    logger.level = (ENV['LOG_LEVEL'] || Logger::INFO).to_i
  end,
  server_middlewares: [],
  health_examinees: []
)
