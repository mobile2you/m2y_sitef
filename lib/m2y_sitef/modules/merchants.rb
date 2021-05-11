require "httparty"
module M2ySitef

  class Merchants < Base

    def self.create_merchant(body)
      url = "#{baseUrl}/#{MERCHANTS_PATH}"
      headers = basicHeaders
      req = HTTParty.post(url, headers: headers, body: body.to_json)
      p req.parsed_response
      if req.code > 300
        return nil
      end
      req.parsed_response
    end
  end
end
