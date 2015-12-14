require File.expand_path('../../test_helper', __FILE__)

module Stripe
  class PaymentTest < Test::Unit::TestCase
    def customer
      @mock.expects(:get).once.returns(test_response(test_customer))
      Stripe::Customer.retrieve('test_customer')
    end

    test 'can create charges' do
      c = customer
      @mock.expects(:post).
            once.
            with("https://api.stripe.com/v1/payments",
                 nil,
                 "customer=#{c.id}&amount=1000&currency=usd&payment_method=ach"
                ).
            returns(test_response(test_payment))
      payment = Stripe::Payment.create customer: customer.id, amount: 10_00, currency: 'usd', payment_method: 'ach'
      assert_kind_of Stripe::Payment, payment
    end
  end
end
