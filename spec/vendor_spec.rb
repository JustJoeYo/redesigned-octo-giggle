require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@vendor).to be_a(Vendor)
    end

    it '#attributes' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to eq({})
    end
  end

  describe 'instance methods' do
    it '#check_stock' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end
  
    it '#stock' do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({@item1 => 30})
      expect(@vendor.check_stock(@item1)).to eq(30)
  
      @vendor.stock(@item1, 25)
      expect(@vendor.check_stock(@item1)).to eq(55)
  
      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end

    it '#potential_revenue' do
      @vendor.stock(@item1, 35)
      @vendor.stock(@item2, 7)
      expect(@vendor.potential_revenue).to eq(29.75)
    end
  end

  describe 'class methods' do

  end
end