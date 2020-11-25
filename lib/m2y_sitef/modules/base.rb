module M2ySitef

  class Base

    def self.baseUrl
      M2ySitef.configuration.server_url
    end

    def self.basicHeaders
      {'Content-Type' => "application/json", 'merchant_id' => M2ySitef.configuration.merchant_id, 'merchant_key' => M2ySitef.configuration.merchant_key }
    end

  end
end
