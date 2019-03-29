require 'sidekiq'

class CheckingWorker
  include Sidekiq::Worker
  sidekiq_options backtrace: true, retry: 1, queue: 'critical'

  def perform(time)
    Tracking.create(request_at: time)
  end
end
