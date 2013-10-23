Sidekiq.configure_server do |config|
  ActiveRecord::Base.configurations = {'development' => {'pool' =>  12 },
                                    'production' => {'pool' =>  12 }}
end
