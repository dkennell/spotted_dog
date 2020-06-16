class SpottedDog

  MAX_ITEM_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      decrement_item_sell_time(item)
      if item.sell_in < 0
        update_expired_item_quality(item)
      else
        update_unexpired_item_quality(item)
      end
    end
  end

  def update_unexpired_item_quality(item)
    if item_deteriorates_normally(item)
      decrement_quality(item)
    else
      handle_abnormally_deteriorating_item(item)
    end
  end

  def update_expired_item_quality(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality = 0
      return
    end
    item.quality =  item.quality - 2
  end

  def decrement_quality(item)
    item.quality = item.quality - 1
    # Decrement quality an additional point if conjured
    if item.name.include?('Conjured')
      item.quality = item.quality - 1
    end
  end

  def handle_abnormally_deteriorating_item(item)
    if item.quality >= MAX_ITEM_QUALITY
      return
    end
    if item_does_not_deteriorate(item)
      return
    end
    # Increase value by one for both concert ticket and brie
    item.quality = item.quality + 1
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      # Value of concert tickets rises faster as concert date approaches
      item.quality = item.sell_in <= 10 ? item.quality + 1 : item.quality
      item.quality = item.sell_in <= 5 ? item.quality + 1 : item.quality
    end
  end

  def decrement_item_sell_time(item)
    if item_sell_date_decrements_normally(item)
      item.sell_in = item.sell_in - 1
    end
  end

  def item_sell_date_decrements_normally(item)
     item.name != "Sulfuras, Hand of Ragnaros"
  end

  def item_deteriorates_normally(item)
    item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert" and item.name != "Sulfuras, Hand of Ragnaros"
  end

  def item_does_not_deteriorate(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end
end
