require 'csv'
require 'pp'
"pid,item,description,price,condition,dimension_w,dimension_l,dimension_h,img_file,quantity"

	
class FurnitureItem
	def initialize(item)
	  shud_b_ints = ["pid","price","dimension_w","dimension_h","dimension_l","quantity"]
	  item = _numerify_data(item, shud_b_ints)

	  clearance_ops = {
	  	"good" => 0.10,
	  	"average" => 0.20
	  }

	  item = _clearance(item, clearance_ops)
	  
	  @props = item
	end

	def _numerify_data(item, prop_group)
		prop_group.each do |prop|
		  item[prop] = item[prop].to_i
		end
		
		return item
	end

	def _clearance(item, options)
		if options.has_key?(item["condition"])
			discount = options[item["condition"]]
			item["price"] * (1-discount)
			clearance_status = true
		else
			item.merge!({"on_clearance"=> false})
			clearance_status = false
		end

        return item.merge!({"on_clearance"=>clearance_status})       
	end

	attr_accessor :props
end

class MainController < ApplicationController
  def home
  	 @inventory = []

    CSV.foreach('./data-import/mf_inventory.csv', headers: true) do |row|
      @inventory.push(FurnitureItem.new(row.to_hash))
    end

     @category_collection_hash = @inventory.reduce({}) do |cat_coll, item|
    	itm = item.props

    	if cat_coll.has_key?(itm["category"]) == false
    		cat_coll.merge!({"#{itm['category']}"=> [] })
    	end

    	cat_coll["#{itm['category']}"].push(itm)
    	cat_coll
    end


  end

  def multi
  	@inventory = []
    
    CSV.foreach('./data-import/mf_inventory.csv', headers: true) do |row|
      @inventory.push(FurnitureItem.new(row.to_hash))
    end

    puts "-"*20

    @category_collection_hash = @inventory.reduce({}) do |cat_coll, item|
    	itm = item.props

    	if cat_coll.has_key?(itm["category"]) == false
    		cat_coll.merge!({"#{itm['category']}"=> [] })
    	end

    	cat_coll["#{itm['category']}"].push(itm)
    end       
  end

  def single
  	@inventory = []
    
    CSV.foreach('./data-import/mf_inventory.csv', headers: true) do |row|
      @inventory.push(FurnitureItem.new(row.to_hash))
    end

    @single_listing = @inventory.find do |item|
      item.props['pid']==params["id"].to_i
    end

    puts @single_listing
  end
end
