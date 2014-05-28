module Stripe
  class Payment < APIResource
    include Stripe::APIOperations::Create
  end
end
