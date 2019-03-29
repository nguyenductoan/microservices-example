require 'grpc'
require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "SampleService.SampleCallRequest" do
    optional :member_id, :int64, 1
  end

  add_message "SampleService.SampleCallReply" do
    optional :name, :string, 1
    optional :email, :string, 2
    optional :address, :string, 3
  end
end

module SampleService
  SampleCallRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("SampleService.SampleCallRequest").msgclass
  SampleCallReply = Google::Protobuf::DescriptorPool.generated_pool.lookup("SampleService.SampleCallReply").msgclass

  module RpcServer
    class Service
      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'SampleService.RpcServer'

      rpc :SampleCall, SampleCallRequest, SampleCallReply
    end

    Stub = Service.rpc_stub_class
  end
end

EhProtobuf.generate_client(SampleService)
