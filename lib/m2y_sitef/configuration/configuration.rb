# frozen_string_literal: true

module M2ySitef
  class Configuration

    attr_writer :server_url, :merchant_id, :merchant_key

    def initialize #:nodoc:
      @server_url = nil
      @merchant_id = nil
      @merchant_key = nil
    end

    def server_url
      @server_url
    end

    def merchant_id
      @merchant_id
    end

    def merchant_key
      @merchant_key
    end

  end
end
