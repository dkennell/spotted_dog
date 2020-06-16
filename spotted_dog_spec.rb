extend RSpec::Matchers

require File.join(File.dirname(__FILE__), 'models/item')
require File.join(File.dirname(__FILE__), 'models/spotted_dog')

describe SpottedDog do
  #
  # describe "#update_quality" do
  #   it "does not change the name" do
  #     items = [Item.new("foo", 0, 0)]
  #     SpottedDog.new(items).update_quality()
  #     expect(items[0].name).to eq "fixme"
  #   end
  # end

  describe "#update_quality" do
    describe "normally deteriorating items" do
      before(:each) do
        @hat = Item.new("hat", 8, 6)
        @s = SpottedDog.new([@hat])
      end

      it "decrements quality by one" do
        expect(@hat.quality).to eq(6)
        @s.update_quality
        expect(@hat.quality).to eq(5)
      end

      it "decrements sell_time by one" do
        expect(@hat.sell_in).to eq(8)
        @s.update_quality
        expect(@hat.sell_in).to eq(7)
      end

      it "when sell_time is at or below zero, it decrements quality by two" do
        @hat.sell_in = 0
        expect(@hat.quality).to eq(6)
        @s.update_quality
        expect(@hat.quality).to eq(4)
      end
    end

    describe "nondeteriorating items" do
      it "does not deteriorate when updated" do
        hand = Item.new("Sulfuras, Hand of Ragnaros", 15, 6)
        s = SpottedDog.new([hand])

        expect(hand.quality).to eq(6)
        s.update_quality
        expect(hand.quality).to eq(6)
      end
    end

    describe "abnormally deteriorating items" do
      describe "concert ticket" do
        before(:each) do
          @ticket = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 6)
          @s = SpottedDog.new([@ticket])
        end

        it "increases quality by one when there are more than 10 days left" do
          expect(@ticket.quality).to eq(6)
          @s.update_quality
          expect(@ticket.quality).to eq(7)
        end

        it "increases quality by two when there are between 5 and 10 days left" do
          @ticket.sell_in = 7
          expect(@ticket.quality).to eq(6)
          @s.update_quality
          expect(@ticket.quality).to eq(8)
        end

        it "increases quality by three when there are fewer than 5 days left" do
          @ticket.sell_in = 3
          expect(@ticket.quality).to eq(6)
          @s.update_quality
          expect(@ticket.quality).to eq(9)
        end

        it "drops value to zero when the concert is over" do
          @ticket.sell_in = 0
          expect(@ticket.quality).to eq(6)
          @s.update_quality
          expect(@ticket.quality).to eq(0)
        end
      end

      describe "brie" do
        it "increases in quality when updated" do
          brie = Item.new("Aged Brie", 15, 6)
          @s = SpottedDog.new([brie])

          expect(brie.quality).to eq(6)
          @s.update_quality
          expect(brie.quality).to eq(7)
        end
      end
    end
  end

end
