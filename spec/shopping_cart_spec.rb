require_relative '../shopping_cart'

RSpec.describe ShoppingCart do
  let(:pricing_rules) { PriceRule::ALL }

  describe 'Scenario 1' do
    let(:three_ult_small) { Product.ult_small(3) }
    let(:one_ult_large) { Product.ult_large }
    let(:shopping_cart) { ShoppingCart.new(pricing_rules) }

    before do
      shopping_cart.add(three_ult_small)
      shopping_cart.add(one_ult_large)
    end

    context '#total' do
      it { expect(shopping_cart.total).to eql('94.70') }
    end

    context '#total_with_currency' do
      it { expect(shopping_cart.total_with_currency).to eql('$94.70') }
    end

    context '#items' do
      before do
        shopping_cart.total
      end

      it { expect(shopping_cart.items.size).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:quantity]).to eql(3) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:description]).to eql('3 X Unlimited 1GB') }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}[:quantity]).to eql(1) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}[:description]).to eql('1 X Unlimited 5GB') }
    end
  end

  describe 'Scenario 2' do
    let(:two_ult_small) { Product.ult_small(2) }
    let(:four_ult_large) { Product.ult_large(4) }
    let(:shopping_cart) { ShoppingCart.new(pricing_rules) }

    before do
      shopping_cart.add(two_ult_small)
      shopping_cart.add(four_ult_large)
    end

    context '#total' do
      it { expect(shopping_cart.total).to eql('209.40') }
    end

    context '#total_with_currency' do
      it { expect(shopping_cart.total_with_currency).to eql('$209.40') }
    end

    context '#items' do
      before do
        shopping_cart.total
      end

      it { expect(shopping_cart.items.size).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:quantity]).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:description]).to eql('2 X Unlimited 1GB') }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}[:quantity]).to eql(4) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_large'}[:description]).to eql('4 X Unlimited 5GB') }
    end
  end

  describe 'Scenario 3' do
    let(:one_ult_small) { Product.ult_small }
    let(:two_ult_medium) { Product.ult_medium(2) }
    let(:shopping_cart) { ShoppingCart.new(pricing_rules) }

    before do
      shopping_cart.add(one_ult_small)
      shopping_cart.add(two_ult_medium)
    end

    context '#total' do
      it { expect(shopping_cart.total).to eql('84.70') }
    end

    context '#total_with_currency' do
      it { expect(shopping_cart.total_with_currency).to eql('$84.70') }
    end

    context '#items' do
      before do
        shopping_cart.total
      end

      it { expect(shopping_cart.items.size).to eql(3) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:quantity]).to eql(1) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:description]).to eql('1 X Unlimited 1GB') }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_medium'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_medium'}[:quantity]).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_medium'}[:description]).to eql('2 X Unlimited 2GB') }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}[:quantity]).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}[:description]).to eql('2 X 1 GB Data-pack') }
    end
  end

  describe 'Scenario 4' do
    let(:one_ult_small) { Product.ult_small }
    let(:one_data_pack) { Product.one_gb }
    let(:promo_code) { 'I<3AMAYSIM' }
    let(:shopping_cart) { ShoppingCart.new(pricing_rules) }

    before do
      shopping_cart.add(one_ult_small)
      shopping_cart.add(one_data_pack, promo_code)
    end

    context '#total' do
      it { expect(shopping_cart.total).to eql('31.32') }
    end

    context '#total_with_currency' do
      it { expect(shopping_cart.total_with_currency).to eql('$31.32') }
    end

    context '#items' do
      before do
        shopping_cart.total
      end

      it { expect(shopping_cart.items.size).to eql(2) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:quantity]).to eql(1) }
      it { expect(shopping_cart.items.find{|item| item[:code] == 'ult_small'}[:description]).to eql('1 X Unlimited 1GB') }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}).not_to be_nil }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}[:quantity]).to eql(1) }
      it { expect(shopping_cart.items.find{|item| item[:code] == '1gb'}[:description]).to eql('1 X 1 GB Data-pack') }
    end
  end
end