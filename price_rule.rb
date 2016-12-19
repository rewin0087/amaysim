class PriceRule
  ALL = {
    ult_small: {
      offer: {
        type: 'MAX_SAME_ITEM_PACKAGE_DISCOUNT',
        quantity_required: {
          min: 3,
          max: 3
        },
        discounted_price: 49.80
      }
    },
    ult_medium: {
      offer: {
        type: 'FREE_PACKAGE_PER_ITEM_DISCOUNT',
        quantity_required: {
          min: 1,
          max: 99999999999
        },
        free: {
          product: :one_gb
        }
      }
    },
    ult_large: {
      offer: {
        type: 'MIN_PER_ITEM_DISCOUNT',
        quantity_required: {
          min: 4,
          max: 99999999999
        },
        discount_per_item: 39.90
      }
    },
    promo_code: {
      percentage: 10,
      code: 'I<3AMAYSIM'
    }
  }

  OFFER_TYPES = %w(MAX_SAME_ITEM_PACKAGE_DISCOUNT FREE_PACKAGE_PER_ITEM_DISCOUNT MIN_PER_ITEM_DISCOUNT)

  OFFER_TYPES.each do |type|
    define_singleton_method type.downcase do
      type
    end
  end
end