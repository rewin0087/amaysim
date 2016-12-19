require_relative '../price_rule'

RSpec.describe PriceRule do
  describe '::ALL' do
    context 'products' do
      it { expect(PriceRule::ALL.keys).to include(:ult_small) }
      it { expect(PriceRule::ALL.keys).to include(:ult_medium) }
      it { expect(PriceRule::ALL.keys).to include(:ult_large) }
    end

    context 'ult_small' do
      let(:rule) { PriceRule::ALL[:ult_small] }

      it { expect(rule[:offer][:type]).to eql('MAX_SAME_ITEM_PACKAGE_DISCOUNT') }
      it { expect(rule[:offer][:quantity_required][:min]).to eql(3) }
      it { expect(rule[:offer][:quantity_required][:max]).to eql(3) }
      it { expect(rule[:offer][:discounted_price]).to eql(49.80) }
    end

    context 'ult_medium' do
      let(:rule) { PriceRule::ALL[:ult_medium] }

      it { expect(rule[:offer][:type]).to eql('FREE_PACKAGE_PER_ITEM_DISCOUNT') }
      it { expect(rule[:offer][:quantity_required][:min]).to eql(1) }
      it { expect(rule[:offer][:quantity_required][:max]).to eql(99999999999) }
      it { expect(rule[:offer][:free][:product]).to eql(:one_gb) }
    end

    context 'ult_large' do
      let(:rule) { PriceRule::ALL[:ult_large] }

      it { expect(rule[:offer][:type]).to eql('MIN_PER_ITEM_DISCOUNT') }
      it { expect(rule[:offer][:quantity_required][:min]).to eql(4) }
      it { expect(rule[:offer][:quantity_required][:max]).to eql(99999999999) }
      it { expect(rule[:offer][:discount_per_item]).to eql(39.90) }
    end

    context 'promo_code' do
      let(:rule) { PriceRule::ALL[:promo_code] }

      it { expect(rule[:percentage]).to eql(10) }
      it { expect(rule[:code]).to eql('I<3AMAYSIM') }
    end
  end

  describe '::OFFER_TYPES' do
    it { expect(PriceRule::OFFER_TYPES).to eql(['MAX_SAME_ITEM_PACKAGE_DISCOUNT', 'FREE_PACKAGE_PER_ITEM_DISCOUNT', 'MIN_PER_ITEM_DISCOUNT']) }
  end

  describe 'class methods' do
    it { expect(PriceRule.max_same_item_package_discount).to eql('MAX_SAME_ITEM_PACKAGE_DISCOUNT') }
    it { expect(PriceRule.free_package_per_item_discount).to eql('FREE_PACKAGE_PER_ITEM_DISCOUNT') }
    it { expect(PriceRule.min_per_item_discount).to eql('MIN_PER_ITEM_DISCOUNT') }
  end
end