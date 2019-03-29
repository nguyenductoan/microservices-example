require 'eh_protobuf'

class BaseHandler
  extend EhProtobuf::Handler::Dsl
  eh_protobuf_service SampleService

  attr_reader :request, :meta

  def initialize(request, meta)
    @request = request
    @meta = meta
  end
end
