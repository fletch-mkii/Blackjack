require_relative '../../lib/blackjack'

describe Card do
  let(:card) { Card.new("♣","K") }

  describe "#initialize" do
    it "builds a card object with suit and rank attributes" do
      expect(card.suit).to eq("♣")
      expect(card.rank).to eq("K")
    end
  end
end

# '♦', '♣', '♠', '♥'

describe Deck do
  let(:deck) { Deck.new }

  describe "#create" do
    it "builds a shuffled deck of card objects" do
      expect(deck.cards[0]).to be_a(Card)
    end
  end

  describe "#draw" do
    it "removes one card from the top of the deck" do
      full_deck = Deck.new
      deck.draw
      expect(deck.cards.length).to eq(full_deck.cards.length - 1)
    end
  end
end

describe Hand do
  let(:deck) { Deck.new }
  let(:hand) { Hand.new(deck) }

  describe "#current_hand" do
    it "existing hand as an array of card objects" do
      expect(hand.current_hand).to be_a(Array)
      expect(hand.current_hand[0]).to be_a(Card)
    end
  end

  describe "#draw" do
    it "adds card from the top of the deck to the hand" do
      original_size = hand.current_hand.length
      hand.draw
      expect(hand.current_hand.length).to eq(original_size + 1)
    end
  end
end

describe Blackjack do
  let(:deck) { Deck.new }
  let(:hand_dealer) { Hand.new(deck) }
  let(:hand_player) { Hand.new(deck) }
  let(:blackjack) {Blackjack.new(hand_dealer, hand_player)}

  describe "#player_hand" do
    it "check that each player draws differently" do
      expect(blackjack.dealer_hand) !=  blackjack.player_hand
    end
  end

  describe "#play" do
    it "prints the out the card drawn" do
      allow(blackjack).to receive(:gets).and_return("H")
      expect{blackjack.play}.to output(/Player drew.*/).to_stdout
    end

    it "adds cards to the hand" do
      allow(blackjack).to receive(:gets).and_return("H")
      blackjack.play
      expect(blackjack.player_hand.current_hand.length).to be > (2)
    end
  end

  describe "#dealer" do
    let(:card1) { Card.new("♥","7") }
    let(:card2) { Card.new("♣","2") }
    let(:card3) { Card.new("♣","K") }
    let(:hand_test) { Hand.new(deck)}

    it "draws for the dealer when score less than 17" do
      hand_test.current_hand = [card1, card2]
      blackjack.dealer_hand = hand_test
      blackjack.dealer
      expect(blackjack.dealer_hand.current_hand.length).to be > (2)
    end

    it "does not draw because score is at or above 17" do
      hand_test.current_hand = [card1, card3]
      blackjack.dealer_hand = hand_test
      blackjack.dealer
      expect(blackjack.dealer_hand.current_hand.length).to eq(2)
    end
  end
end
