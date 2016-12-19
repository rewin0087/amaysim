require_relative '../product'

RSpec.describe Product do
  describe '::ALL' do
    context 'ult_small' do
      let(:ult_small) { { code: 'ult_small', name: 'Unlimited 1GB', price: 24.90, key: :ult_small } }
      it { expect(Product::ALL[:ult_small]).to eql(ult_small) }
    end

    context 'ult_medium' do
      let(:ult_medium) { { code: 'ult_medium', name: 'Unlimited 2GB', price: 29.90, key: :ult_medium } }
      it { expect(Product::ALL[:ult_medium]).to eql(ult_medium) }
    end

    context 'ult_large' do
      let(:ult_large) { { code: 'ult_large', name: 'Unlimited 5GB', price: 44.90, key: :ult_large } }
      it { expect(Product::ALL[:ult_large]).to eql(ult_large) }
    end

    context 'one_gb' do
      let(:one_gb) { { code: '1gb', name: '1 GB Data-pack', price: 9.90, key: :one_gb } }
      it { expect(Product::ALL[:one_gb]).to eql(one_gb) }
    end
  end

  describe 'class methods' do
    context '.ult_small' do
      let(:item) { Product.ult_small }

      it { expect(item.code).to eql('ult_small') }
      it { expect(item.name).to eql('Unlimited 1GB') }
      it { expect(item.price).to eql(24.90) }
      it { expect(item.key).to eql(:ult_small) }
      it { expect(item.quantity).to eql(1) }
    end

    context '.ult_medium' do
      let(:item) { Product.ult_medium }

      it { expect(item.code).to eql('ult_medium') }
      it { expect(item.name).to eql('Unlimited 2GB') }
      it { expect(item.price).to eql(29.90) }
      it { expect(item.key).to eql(:ult_medium) }
      it { expect(item.quantity).to eql(1) }
    end

    context '.ult_large' do
      let(:item) { Product.ult_large }

      it { expect(item.code).to eql('ult_large') }
      it { expect(item.name).to eql('Unlimited 5GB') }
      it { expect(item.price).to eql(44.90) }
      it { expect(item.key).to eql(:ult_large) }
      it { expect(item.quantity).to eql(1) }
    end

    context '.one_gb' do
      let(:item) { Product.one_gb }

      it { expect(item.code).to eql('1gb') }
      it { expect(item.name).to eql('1 GB Data-pack') }
      it { expect(item.price).to eql(9.90) }
      it { expect(item.key).to eql(:one_gb) }
      it { expect(item.quantity).to eql(1) }
    end
  end

end