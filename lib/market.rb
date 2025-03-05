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
end