require_relative 'card'

class Deck
  attr_reader :cards
  
  SUITS = ['♦', '♣', '♠', '♥']
  RANKS = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']

  def initialize
    @cards = create
  end

  def create
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(suit,rank)
      end
    end
    cards.shuffle!
  end

  def draw
    @cards.pop
  end

end
