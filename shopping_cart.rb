class ShoppingCart
  attr_reader :rules,
    :items,
    :original_items,
    :total,
    :promo_code

  DEFAULT_CURRENCY = '$'

  def initialize(rules = {})
    @rules = rules
    @items = []
    @original_items = []
  end

  def add(item, promo_code = nil)
    @promo_code = promo_code if promo_code
    @original_items << item
  end

  def total
    calculate_items
    total_price = @items.map{|item| item[:price]}.inject(&:+)

    if @promo_code && @rules.has_key?(:promo_code)
      discount_price = @rules[:promo_code][:code] == @promo_code ? ((@rules[:promo_code][:percentage].to_f / 100.to_f) * total_price) : 0
      total_price -= discount_price
    end

    ('%.2f' % total_price)
  end

  def total_with_currency
    "#{DEFAULT_CURRENCY}#{total}"
  end

  private

  def evaluate_item_and_apply_rules(product_code, total_items)
    current_rule = @rules.has_key?(product_code) ? @rules[product_code.to_sym] : nil
    current_product = Product::ALL[product_code.to_sym]
    offer = current_rule ? current_rule[:offer] : nil
    price = 0

    if current_rule && (total_items >= offer[:quantity_required][:min] && total_items <= offer[:quantity_required][:max])
      if offer[:type] == PriceRule.max_same_item_package_discount
        price = offer[:discounted_price]
      elsif offer[:type] == PriceRule.free_package_per_item_discount
        add_free_package(offer[:free][:product], total_items)
        price = current_product[:price] * total_items
      elsif offer[:type] == PriceRule.min_per_item_discount
        price = offer[:discount_per_item] * total_items
      else
        price = current_product[:price] * total_items
      end
    else
      price = current_product[:price] * total_items
    end

    build_item(current_product, price, total_items)
  end

  def add_free_package(product_code, quantity)
    free_product = Product::ALL[product_code.to_sym]
    @items << build_item(free_product, 0, quantity)
  end

  def build_item(current_product, price, total_items)
    {
      code: current_product[:code],
      name: current_product[:name],
      price: price,
      quantity: total_items,
      description: "#{total_items} X #{current_product[:name]}"
    }
  end

  def calculate_items
    @items.clear
    original_items = @original_items.group_by(&:key)
    original_items.each do |product_code, items|
      total_items = items.map(&:quantity).inject(&:+)
      @items << evaluate_item_and_apply_rules(product_code, total_items)
    end
  end
end