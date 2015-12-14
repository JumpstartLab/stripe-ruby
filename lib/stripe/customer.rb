module Stripe
  class Customer < APIResource
    extend Stripe::APIOperations::Create
    include Stripe::APIOperations::Delete
    include Stripe::APIOperations::Update
    extend Stripe::APIOperations::List

    def add_invoice_item(params, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      InvoiceItem.create(params.merge(:customer => id), opts)
    end

    def invoices(params={}, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      Invoice.all(params.merge(:customer => id), opts)
    end

    def invoice_items(params={}, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      InvoiceItem.all(params.merge(:customer => id), opts)
    end

    def upcoming_invoice(params={}, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      Invoice.upcoming(params.merge(:customer => id), opts)
    end

    def charges(params={}, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      Charge.all(params.merge(:customer => id), opts)
    end

    def create_upcoming_invoice(params={}, opts={})
      opts = @opts.merge(Util.normalize_opts(opts))
      Invoice.create(params.merge(:customer => id), opts)
    end

    def cancel_subscription(params={}, opts={})
      response, opts = request(:delete, subscription_url, params, opts)
      initialize_from({ :subscription => response }, opts, true)
      subscription
    end

    def update_subscription(params={}, opts={})
      response, opts = request(:post, subscription_url, params, opts)
      initialize_from({ :subscription => response }, opts, true)
      subscription
    end

    def create_subscription(params={}, opts={})
      response, opts = request(:post, subscriptions_url, params, opts)
      initialize_from({ :subscription => response }, opts, true)
      subscription
    end

    def delete_discount
      _, opts = request(:delete, discount_url)
      initialize_from({ :discount => nil }, opts, true)
    end

    def bank_accounts
      response, api_key = Stripe.request(:get, bank_accounts_url, @api_key)
      response[:data].each do |bank_account_data|
        bank_account_data[:customer] = id
      end
      Util.convert_to_stripe_object(response, api_key)
    end

    private

    def discount_url
      url + '/discount'
    end

    def subscription_url
      url + '/subscription'
    end

    def subscriptions_url
      url + '/subscriptions'
    end

    def bank_accounts_url
      url + '/bank_accounts'
    end
  end
end
