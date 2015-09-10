require 'csv'
require 'pp'
"pid,item,description,price,condition,dimension_w,dimension_l,dimension_h,img-file,quantity"


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
    
  end

  def multi
  	@inventory = []
    
    CSV.foreach('./data-import/mf_inventory.csv', headers: true) do |row|
      @inventory.push(FurnitureItem.new(row.to_hash))
    end

  end

  def single
  	@inventory = []
    
    CSV.foreach('./data-import/mf_inventory.csv', headers: true) do |row|
      @inventory.push(FurnitureItem.new(row.to_hash))
    end

    @single_listing = @inventory.find do |item|
      item['pid']==params.id
    end
  end
end
