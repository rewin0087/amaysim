class Product
  ALL = {
    ult_small: { code: 'ult_small', name: 'Unlimited 1GB', price: 24.90, key: :ult_small },
    ult_medium: { code: 'ult_medium', name: 'Unlimited 2GB', price: 29.90, key: :ult_medium },
    ult_large: { code: 'ult_large', name: 'Unlimited 5GB', price: 44.90, key: :ult_large },
    one_gb: { code: '1gb', name: '1 GB Data-pack', price: 9.90, key: :one_gb }
  }

  attr_reader :code,
    :name,
    :price,
    :quantity,
    :key

  def initialize(attributes = {})
    @code = attributes[:code] || ''
    @name = attributes[:name] || ''
    @price = attributes[:price] || 0
    @quantity = attributes[:quantity] || 1
    @key = attributes[:key] || ''
  end

  def self.ult_small(quantity = 1)
    product = ALL[:ult_small]
    product[:quantity] = quantity
    new(product)
  end

  def self.ult_medium(quantity = 1)
    product = ALL[:ult_medium]
    product[:quantity] = quantity
    new(product)
  end

  def self.ult_large(quantity = 1)
    product = ALL[:ult_large]
    product[:quantity] = quantity
    new(product)
  end

  def self.one_gb(quantity = 1)
    product = ALL[:one_gb]
    product[:quantity] = quantity
    new(product)
  end
end