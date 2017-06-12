module Bitcoin
  class Client
    def self.local
      return Bitcoin::Client.new(ENV['RPC_USER'], ENV['RPC_PASSWORD'],
        { host: 'Host IP', port: 45443, ssl: false} )
    end
  end
end
