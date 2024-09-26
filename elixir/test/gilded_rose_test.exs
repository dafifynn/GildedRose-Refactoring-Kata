defmodule GildedRoseTest do
  use ExUnit.Case

  describe "testing Aged Brie items" do

    test "increases in Quality the older it gets" do
      items = [%Item{name: "Aged Brie", sell_in: 5, quality: 2}, %Item{name: "Aged Brie", sell_in: 4, quality: 4}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 4 == item1.sell_in
      assert 3 == item1.quality
      assert 3 == item2.sell_in
      assert 5 == item2.quality
    end

    test "the Quality of an item is never more than 50" do
      items = [%Item{name: "Aged Brie", sell_in: 5, quality: 49}, %Item{name: "Aged Brie", sell_in: 4, quality: 50}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 50 == item1.quality
      assert 50 == item2.quality

      items = [item1, item2]
      [item1, item2] = GildedRose.update_quality(items)
      assert 50 == item1.quality
      assert 50 == item2.quality
    end
  end

  describe "testing Sulfuras items" do
    test "never has to be sold or decreases in Quality" do
      items = [%Item{name: "Sulfuras, Hand of Ragnaros", quality: 80}]
      item = List.first(GildedRose.update_quality(items))
      assert nil == item.sell_in
      assert 80 == item.quality
    end
  end

  describe "testing Backstage passes items" do
    test "increases in Quality as its SellIn value approaches" do
      items = [%Item{name: "Aged Brie", sell_in: 30, quality: 2}, %Item{name: "Aged Brie", sell_in: 25, quality: 4}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 29 == item1.sell_in
      assert 3 == item1.quality
      assert 24 == item2.sell_in
      assert 5 == item2.quality
    end

    test "quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 15}, %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 6, quality: 11}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 9 == item1.sell_in
      assert 17 == item1.quality
      assert 5 == item2.sell_in
      assert 13 == item2.quality

      items = [item1, item2]
      [item1, item2] = GildedRose.update_quality(items)
      assert 8 == item1.sell_in
      assert 19 == item1.quality
      assert 4 == item2.sell_in
      assert 16 == item2.quality
    end

    test "quality drops to 0 after the concert" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 2}, %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 4}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 0 == item1.sell_in
      assert 5 == item1.quality
      assert -1 == item2.sell_in
      assert 0 == item2.quality
    end
  end

  describe "testing Conjured items" do
    test "degrade in Quality twice as fast as normal items" do
      items = [%Item{name: "Regular item", sell_in: 3, quality: 10}, %Item{name: "Conjured", sell_in: 3, quality: 10}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 2 == item1.sell_in
      assert 9 == item1.quality
      assert 2 == item2.sell_in
      assert 8 == item2.quality

      items = [%Item{name: "Regular item", sell_in: -1, quality: 10}, %Item{name: "Conjured", sell_in: -1, quality: 10}]
      [item1, item2] = GildedRose.update_quality(items)
      assert -2 == item1.sell_in
      assert 8 == item1.quality
      assert -2 == item2.sell_in
      assert 6 == item2.quality
    end

    test "the Quality of an item is never negative" do
      items = [%Item{name: "Conjured", sell_in: 2, quality: 1}, %Item{name: "Conjured", sell_in: -1, quality: 2}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 1 == item1.sell_in
      assert 0 == item1.quality
      assert -2 == item2.sell_in
      assert 0 == item2.quality
    end
  end

  describe "testing Regular items" do
    test "constantly degrading in Quality as they approach their sell by date" do
      items = [%Item{name: "Regular item", sell_in: 4, quality: 10}, %Item{name: "Regular item", sell_in: 5, quality: 8}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 3 == item1.sell_in
      assert 9 == item1.quality
      assert 4 == item2.sell_in
      assert 7 == item2.quality
    end

    test "once the sell by date has passed, Quality degrades twice as fast" do
      items = [%Item{name: "Regular item", sell_in: -1, quality: 10}, %Item{name: "Regular item", sell_in: -1, quality: 8}]
      [item1, item2] = GildedRose.update_quality(items)
      assert -2 == item1.sell_in
      assert 8 == item1.quality
      assert -2 == item2.sell_in
      assert 6 == item2.quality
    end

    test "the Quality of an item is never negative" do
      items = [%Item{name: "Regular item", sell_in: 2, quality: 0}, %Item{name: "Regular item", sell_in: 0, quality: 0}]
      [item1, item2] = GildedRose.update_quality(items)
      assert 1 == item1.sell_in
      assert 0 == item1.quality
      assert -1 == item2.sell_in
      assert 0 == item2.quality
    end
  end

end
