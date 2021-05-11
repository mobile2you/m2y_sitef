require "httparty"
module M2ySitef

  class Transactions < Base

    def self.checkPix(nit, merchant_id = nil, merchant_key = nil)
      url = "#{baseUrl}/#{TRANSACTIONS_PATH}/#{nit}"
      
      headers = basicHeaders
      if merchant_id.present?
        headers["merchant_id"] = merchant_id
      end
      if merchant_id.present?
        headers["merchant_key"] = merchant_key
      end

      req = HTTParty.get(url, headers: headers)
      if req.code > 300
        return nil
      end
      payment = req.parsed_response["payment"]
      payment[:paid] = payment["status"] == "CON"
      payment
    end

    def self.doPix(amount, order_id, psp = nil, merchant_id = nil, merchant_key = nil)
      body = {
        "order_id": order_id,
        "installments":"1",
        "installment_type":"4",
        "authorizer_id":"440",
        "amount": (amount * 100).to_i
      }
      if psp.present?
        body[:additional_data] = {:pix_psp => psp}
      end

      url = "#{baseUrl}/#{TRANSACTIONS_PATH}"
      headers = basicHeaders
      if merchant_id.present?
        headers["merchant_id"] = merchant_id
      end
      if merchant_id.present?
        headers["merchant_key"] = merchant_key
      end
      req = HTTParty.post(url, headers: headers, body: body.to_json)
      p req.parsed_response
      if req.code > 300
        return nil
      end

      nit = req.parsed_response["payment"]["nit"]
      p nit
      url = "#{baseUrl}/#{PAYMENTS_PATH}/#{nit}"
      p url
      req = HTTParty.post(url, headers: basicHeaders, body: {}.to_json)
      p req.parsed_response
      if req.code > 300
        return nil
      end

      {nit: nit, qrcode: req.parsed_response["payment"]["qr_code"]}
    end
  end
end
