require "pry"
require_relative 'hand'

class Blackjack
attr_accessor :dealer_hand, :player_hand

  def initialize(dealer_hand, player_hand)
    @dealer_hand = dealer_hand
    @player_hand = player_hand
    @choice = ""
  end

  def play
    welcome
    until @choice.upcase == "S" || score(@player_hand) > 21
      print "\nWould you like to hit or stand (H/S):"
      choice
      if @choice.upcase == "H"
        @player_hand.draw
        puts "\nPlayer drew #{@player_hand.current_hand[-1].suit}#{@player_hand.current_hand[-1].rank}"
        puts "#{bust?(score(@player_hand))}\n"
      elsif @choice.upcase == "S"
        dealer
      else
        puts "\nInvalid Input."
      end
    end
  end

  def dealer
    puts "\nDealer was dealt #{@dealer_hand.current_hand[0].suit}#{@dealer_hand.current_hand[0].rank},\
#{@dealer_hand.current_hand[1].suit}#{@dealer_hand.current_hand[1].rank}\nDealer's Score: #{score(@dealer_hand)}"
    while score(@dealer_hand) < 17
      @dealer_hand.draw
      puts "\nDealer drew #{@dealer_hand.current_hand[-1].suit}#{@dealer_hand.current_hand[-1].rank}\nDealer's Score: #{score(@dealer_hand)}"
    end
    puts winner(score(@dealer_hand), score(@player_hand))

  end


private

  def welcome ##combine with hit, make new simple welcome method for strings.
    puts "Welcome to Blackjack!\nPlayer was dealt #{@player_hand.current_hand[0].suit}#{@player_hand.current_hand[0].rank},\
#{@player_hand.current_hand[1].suit}#{@player_hand.current_hand[1].rank}\nPlayer's Score: #{score(@player_hand)}"
  end

  def choice
    @choice = gets.chomp
  end

  def score(hand)
    score = regular_scoring(hand)
    aces = hand.ace_count
    aces.times do
      if score + 11 > 21
        score += 1
      else
        score + 11
      end
    end
    score
  end

  def regular_scoring(hand)
    score = 0
    hand.current_hand.each do |card|
      if /[JQK]/.match(card.rank.to_s)
        score += 10
      elsif /[2-9]|10/.match(card.rank.to_s)
        score += card.rank.to_i
      end
    end
    score
  end

  def bust?(score)
    if score > 21
      winner(score(@dealer_hand), score(@player_hand))
    else
      "Your score is #{score}"
    end
  end

  def winner(dealer_score, player_score)
    if player_score > 21
      "Your score is #{score(@player_hand)}, you bust."
    elsif player_score > dealer_score
      "You win."
    elsif dealer_score >= player_score
      "Dealer wins."
    end
  end

end

##GAME RUN##
# deck = Deck.new
# handp = Hand.new(deck)
# handd = Hand.new(deck)
# blackjack = Blackjack.new(handd, handp)
# blackjack.play
