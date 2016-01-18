require_relative 'deck'

class Hand
  attr_accessor :current_hand

  def initialize(deck)
    @deck = deck
    @current_hand = [@deck.draw, @deck.draw]
  end

  def ace_count
    ace_counter = 0
    @current_hand.each do |card|
      if "A" == card.rank
        ace_counter += 1
      end
    end
    ace_counter
  end

  def draw
    @current_hand << @deck.draw
  end
end
