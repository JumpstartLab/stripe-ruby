module Stripe
  class BankAccount < APIResource
<<<<<<< HEAD
    include Stripe::APIOperations::Update
    include Stripe::APIOperations::Delete
    extend Stripe::APIOperations::List

    def verify(params={}, opts={})
      response, opts = request(:post, url + '/verify', params, opts)
      initialize_from(response, opts)
    end

    def url
      if respond_to?(:customer)
        "#{Customer.url}/#{CGI.escape(customer)}/sources/#{CGI.escape(id)}"
      elsif respond_to?(:account)
        "#{Account.url}/#{CGI.escape(account)}/external_accounts/#{CGI.escape(id)}"
      end
    end

    def self.retrieve(id, opts=nil)
      raise NotImplementedError.new("Bank accounts cannot be retrieved without an account ID. Retrieve a bank account using account.external_accounts.retrieve('card_id')")
=======
    include Stripe::APIOperations::Create
    # include Stripe::APIOperations::Delete
    # include Stripe::APIOperations::Update
    include Stripe::APIOperations::List

    def verified?
      verified
    end

    def verify(*amounts)
      response, api_key = Stripe.request(:post, "#{url}/verify" , @api_key, amounts: amounts)
      # have to set partial to true b/c we don't want to overwrite injected attributes
      refresh_from(response, api_key, true)
    end

    def url
      raise "Need to inject customer until it comes back in the url... this resource was constructed without it " unless respond_to?(:customer)
      "#{Customer.url}/#{CGI.escape(customer)}/bank_accounts/#{CGI.escape(id)}"
>>>>>>> e6c1bd3513933495a7dd34a261c736623f17e07c
    end
  end
end
