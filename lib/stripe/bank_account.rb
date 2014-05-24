module Stripe
  class BankAccount < APIResource
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
    end
  end
end
