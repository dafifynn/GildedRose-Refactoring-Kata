defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in, quality: quality} = item)
      when 50 > quality do
    %{item | quality: quality + 1, sell_in: sell_in - 1}
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
  end

  def update_item(
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in} = item
      )
      when sell_in == 0 do
    %{item | quality: 0, sell_in: sell_in - 1}
  end

  def update_item(
        %Item{
          name: "Backstage passes to a TAFKAL80ETC concert",
          sell_in: sell_in,
          quality: quality
        } = item
      )
      when 5 >= sell_in and sell_in > 0 do
    %{item | quality: min(quality + 3, 50), sell_in: sell_in - 1}
  end

  def update_item(
        %Item{
          name: "Backstage passes to a TAFKAL80ETC concert",
          sell_in: sell_in,
          quality: quality
        } = item
      )
      when 10 >= sell_in and sell_in > 5 do
    %{item | quality: min(quality + 2, 50), sell_in: sell_in - 1}
  end

  def update_item(
        %Item{
          name: "Backstage passes to a TAFKAL80ETC concert",
          sell_in: sell_in,
          quality: quality
        } = item
      )
      when sell_in > 10 do
    %{item | quality: min(quality + 1, 50), sell_in: sell_in - 1}
  end

  def update_item(%Item{name: "Conjured", sell_in: sell_in, quality: quality} = item) when quality > 0 and sell_in > 0 do
    if (quality - 2 ) >= 0 do
      %{item | quality: quality - 2, sell_in: sell_in - 1}
    else
      %{item | quality: 0, sell_in: sell_in - 1}
    end
  end

  def update_item(%Item{name: "Conjured", quality: quality} = item) when quality > 0 do
    if (quality - 4 ) >= 0 do
      %{item | quality: quality - 4, sell_in: item.sell_in - 1}
    else
      %{item | quality: 0, sell_in: item.sell_in - 1}
    end
  end

  def update_item(%Item{name: name, sell_in: sell_in, quality: quality} = item)
      when quality > 0 and sell_in >= 0 and
             name not in ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "conjured"] do
    %{item | quality: quality - 1, sell_in: item.sell_in - 1}
  end

  def update_item(%Item{name: name, sell_in: sell_in, quality: quality} = item)
      when quality > 0 and 0 > sell_in and
             name not in ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "conjured"] do
    %{item | quality: quality - 2, sell_in: item.sell_in - 1}
  end

  def update_item(item) do
    %{item | sell_in: item.sell_in - 1}
  end
end
