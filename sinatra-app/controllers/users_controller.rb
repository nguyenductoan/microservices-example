require 'sinatra/base'

class UsersController < Sinatra::Base
  get '/users' do
    CheckingWorker.perform_async(Time.now)
    User.all.map{ |u| u.values }.to_json
  end
end
