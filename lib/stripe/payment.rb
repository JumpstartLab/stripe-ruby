module Stripe
  class Payment < APIResource
    extend Stripe::APIOperations::Create
  end
end
