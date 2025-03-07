require 'spec_helper' # removed redundant imports

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@market).to be_a(Market)
    end

    describe 'attributes' do
      it '#name/#vendors' do
        expect(@market.name).to eq("South Pearl Street Farmers Market")
        expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
      end
      it '#date' do
        # moved to proper block and gave it room of its own due to the mock
        allow(Date).to receive(:today).and_return(Date.new(2023, 2, 24)) # Mocks and stubs yoooo
        market = Market.new("South Pearl Street Farmers Market")
        expect(market.date).to eq("24/02/2023")
      end
    end
  end

  describe 'instance methods' do
    it '#add_vendor' do
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it '#vendor_names' do
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '#vendors_that_sell' do
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end

    it '#total_inventory' do
      expected_hash = { # will only use once so not moving to before block
        @item1 => { quantity: 100, vendors: [@vendor1, @vendor3] },
        @item2 => { quantity: 7, vendors: [@vendor1] },
        @item3 => { quantity: 25, vendors: [@vendor2] },
        @item4 => { quantity: 50, vendors: [@vendor2] }
      }
      expect(@market.total_inventory).to eq(expected_hash)
    end

    it '#overstocked_items' do
      expect(@market.overstocked_items).to eq([@item1])
    end

    it '#sorted_item_list' do
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end

    it '#sell' do
      # already kinda have stuff in the before block so easily life.
      expect(@market.sell(@item1, 200)).to eq(false)
      expect(@market.sell(@item1, 40)).to eq(true)
      expect(@vendor1.check_stock(@item1)).to eq(0)
      expect(@vendor3.check_stock(@item1)).to eq(60)
    end
  end

  describe 'class methods' do
    # so lonely in here..
  end
end