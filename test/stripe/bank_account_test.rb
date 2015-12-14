require File.expand_path('../../test_helper', __FILE__)

module Stripe
  class BankAccountTest < Test::Unit::TestCase
<<<<<<< HEAD

    should 'be verifiable' do
      bank = Stripe::BankAccount.construct_from({
        :id => 'ba_foo',
        :customer => 'cus_bar'
      })

      @mock.expects(:post).
        once.
        with('https://api.stripe.com/v1/customers/cus_bar/sources/ba_foo/verify', nil, 'amounts[]=1&amounts[]=2').
        returns(make_response(:status => 'verified'))

      bank.verify(:amounts => [1,2])
    end

=======
    def customer
      @mock.expects(:get).once.returns(test_response(test_customer))
      Stripe::Customer.retrieve('test_customer')
    end

    def bank_accounts_url(customer_id)
      "https://api.stripe.com/v1/customers/#{customer_id}/bank_accounts"
    end

    def bank_account_url(customer_id, bank_account_id=nil)
      bank_accounts_url(customer_id) + "/#{bank_account_id}"
    end

    test "can add bank account to customer" do
      c = customer
      @mock.expects(:get).once.with(bank_accounts_url(c.id), nil, nil).returns(test_response test_bank_account_array(c.id))
      @mock.expects(:post).once.with(bank_accounts_url(c.id), nil, 'bank_account=BANK-ACCOUNT-TOKEN').returns(test_response test_bank_account)
      bank_account = c.bank_accounts.create(bank_account: "BANK-ACCOUNT-TOKEN")
      assert_kind_of Stripe::BankAccount, bank_account
    end

    test "can list a customer's bank accounts" do
      c = customer
      @mock.expects(:get).once.with(bank_accounts_url(c.id), nil, nil).returns(test_response test_bank_account_array(c.id))
      bank_account = c.bank_accounts.first
    end

    test "customer's bank accounts are verifiable" do
      c = customer
      bank_accounts = test_bank_account_array(c.id)
      bank_accounts[:data].first[:verified] = false
      @mock.expects(:get).once.with(bank_accounts_url(c.id), nil, nil).returns(test_response bank_accounts)
      bank_account = c.bank_accounts.first
      refute bank_account.verified?
      @mock.expects(:post).once.with(bank_account_url(c.id, bank_account.id) + "/verify", nil, "amounts[]=11&amounts[]=22").
        returns(test_response test_bank_account.merge(verified: true))
      bank_account.verify 11, 22
      assert bank_account.verified?
    end
>>>>>>> e6c1bd3513933495a7dd34a261c736623f17e07c
  end
end
