require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Item do
  before(:each) do
    @item = Item.new({name: 'Peach', price: "$0.75"})
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@item).to be_a(Item)
    end

    it '#attributes' do
      expect(@item.instance_variables).to include(:@name, :@price) # is something like this ever useful/looked for? or just use standard method from attr_reader?
      expect(@item.name).to eq('Peach')
      expect(@item.price).to eq(0.75)
    end
  end

  #placeholder
  describe 'instance methods' do
    
  end

  #placeholder
  describe 'class methods' do

  end
end