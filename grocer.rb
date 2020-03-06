def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
 index = 0
 while index < collection.length do 
   item = collection[index]
   return item if name === item[:item] 
  index += 1 
  end
  nil 
end 

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  
  consolidated = []
  index = 0 
  
  while index < cart.length do 
   item_name = cart[index][:item]
   looking_for = find_item_by_name_in_collection(item_name, consolidated)
   if looking_for
     looking_for[:count] += 1 
   else 
     cart[index][:count] = 1
     consolidated << cart[index]
   end 
   index += 1 
 end 
 consolidated
end

def coupon_hash(coupon)
  rounded_price = (coupon[:cost].to_f * 1.0 / coupon[:num]).round(2)
  {
  :item => "#{coupon[:item]} W/COUPON",
  :price => rounded_price,
  :count => coupon[:num]
  }
end 

def apply_coupon_to_cart(item, coupon, cart)
  item[:count] -= coupon[:num]
  item_with_coupon = coupon_hash(coupon)
  item_with_coupon[:clearance] = item[:clearance]
  cart << item_with_coupon
end 

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  while i < coupons.count do 
  coupon = coupons[index]
  find_item = find_item_by_name_in_collection(coupon[:item], cart)
  item_check = !!find_item
  coupon_applies = item_check && find_item[:count] >= coupon[:num]
  
  if item_check && coupon_applies
    apply_coupon_to_cart(find_item, coupon, cart)
  end 
  i += 1 
end

cart 
end 


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  clearance = []
  
  while i < cart.length do 
    item = cart[i]
    if item[:clearance]
      reduced_price = (1 - CLEARANCE_ITEM_DISCOUNT_RATE) * item[:price].round(2)
      item[:price] = reduced_price 
     end 
  i += 1 
  end
  cart 
end 

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  index = 0
  total = 0 
  
  consolidated = consolidate_cart(cart)
  apply_coupons(consolidated, coupons)
  apply_clearance(consolidated)
  
  while index < consolidated.length do 
    total += items_total_cost(consolidated[:index])
    index += 1 
  end 
  
  total >= 100 ? total * (1.0 - BIG_PURCHASE_DISCOUNT_RATE) : total
end

def items_total_cost(i) 
  i[:count] * i[:price]
end 
