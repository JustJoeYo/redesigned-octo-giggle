# will be asked to record Vendors That Sell later so leaving extra notes for myself (could be moved to describe/it blocks)

class Market
  attr_reader :name, :vendors

  # Initializes a new Market object with a name and an empty array of vendors.
  def initialize(name)
    @name = name
    @vendors = []
  end

  # Adds a vendor to the market's list of vendors.
  def add_vendor(vendor)
    @vendors << vendor
  end

  # Returns an array of the names of all vendors in the market.
  def vendor_names
    @vendors.map(&:name)
  end

    # Returns an array of vendors that sell a !specific! item.
  def vendors_that_sell(item)
    # @vendors is an array of Vendors
    # Using the select method we iterate over each vendor in the @vendors array.
    @vendors.select do |vendor|
      # For each vendor, it checks if the vendor's inventory includes the item.
      vendor.inventory.include?(item)
    end
    # The select method returns a new array containing all the vendors for which the block returns true. 
    # Or in stimple terms:
    # {true, true, false, true} => {true, true, true}, just keeps the vendors that we want cause they have it.
    # more comments than code...
  end

  # Returns a hash with items as keys and hashes as values.
  # The sub-hash has two key/value pairs: quantity and vendors. (copy pasted)
  def total_inventory
    # :quantity is initialized to 0, and :vendors is initialized to an empty array.
    inventory = Hash.new { |hash, key| hash[key] = { quantity: 0, vendors: [] } }
  
    # Iterate over each vendor in the @vendors array.
    @vendors.each do |vendor|
      # For each vendor, iterate over their inventory hash.
      # The inventory hash has items as keys and quantities as values.
      vendor.inventory.each do |item, quantity|
        # Increment the amount of item in the inventory by the quantity from the vendor's inventory.
        inventory[item][:quantity] += quantity
        # Add the vendor to the array of vendors that sell this item.
        inventory[item][:vendors] << vendor
      end
    end
    # Return the inventory hash. Could be return inventory, but yall dont seem to use it so ill follow you.
    inventory
  end

  # Returns an array of items that are overstocked.
  # An item is overstocked if it is sold by more than 1 vendor AND the total quantity is greater than 50. (copy pasted)
  def overstocked_items
    total_inventory.select do |item, data|
      data[:quantity] > 50 && data[:vendors].length > 1
    end.keys
  end

  # Returns an array of names of all the items the vendors have in stock and are also sorted alphabetically.
  # This list does not include any duplicate items. # (copy pasted)
  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.keys.map(&:name)
    end.uniq.sort
  end
end