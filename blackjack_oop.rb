#require "pry"

module Caculate_total
  def self.total(cards)
    t = 0 
    # re-order cards array to push "A"s at the end
    temp = []
    temp2 = []
    cards.each do |c| 
      if (c != "A") ? (temp << c) : (temp2 << c)
      end
    end
    temp = temp.concat(temp2)

    temp.each do |c|
      if (c == "J") || (c == "Q") || (c == "K")
        t = t + 10
      elsif (c == "A")
        if ((t + 11) > 21) ? (t = t + 1) : (t = t +11)
        end
      else
        t = t + c.to_i
      end
    end
    return t   
  end
end

class Participant
  attr_accessor :total, :cards, :card_values
  
  def initialize(name = nil)
    @total = 0
    @cards = []
    @card_values = []
  end

  def recieve_card(card)
    @cards << card
    @card_values << card.value
    @total = Caculate_total.total(@card_values)
  end
end

class Player < Participant
  attr_accessor :name
  
  def initialize(name)
    super
    @name = name
  end

end

class Dealer < Participant
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ["H", "D", "S", "C"].each do |suit|
      ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    scramble!
  end

  def scramble!
     cards.shuffle!
  end

  def deal
    cards.pop
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end

  def info
    return "#{value} of #{suit}"
  end

end

class Blackjack

  def setup
    @player = Player.new("Jong")
    @dealer = Dealer.new
    @deck = Deck.new

    2.times do
      @player.recieve_card(@deck.deal)
      @dealer.recieve_card(@deck.deal)
    end
  end

  def run
    
    setup

    puts "Welcome, #{@player.name}! Let's play Blackjack."
    @player.cards.each {|c| puts "#{@player.name} has #{c.info}" }
    @dealer.cards.each {|c| puts "Dealer havs #{c.info}" }
    puts "#{@player.name} has #{@player.total}"
    puts "Dealer has #{@dealer.total}"
    if (@player.total == 21)
      puts "#{@player.name} wins!! #{@player.name} has BlackJack!!"
    elsif (@dealer.total == 21) 
      puts "Dealer wins!! Dealer has BlackJack!!"
    else
      # Neither has BlasckJack. Let's play!!
      while true 
        puts "1)hit? or 2)stay?"
        status = gets.chomp
        if status == "2"
          break
        else
          @player.recieve_card(@deck.deal)
          puts "#{@player.name}'s card is #{@player.cards.last.info}"
          puts "#{@player.name}'s total is #{@player.total}"
          if @player.total > 21
            puts "#{@player.name} busted!! #{@player.name} lost."
            break
          end
        end
      end

      if @player.total <= 21 
        puts "Now, It is Dealers turn"
        while true 
          if (@dealer.total > 16) && (@dealer.total <= 21)
            puts "Dealer stops"
            puts "#{@player.name} wins!!" if (@player.total > @dealer.total)
            puts "#{@player.name} looses!!" if (@player.total < @dealer.total)
            puts "#{@player.name} draws!!" if (@player.total == @dealer.total)
            break
          elsif (@dealer.total > 21)
            puts "Dealer busted!! #{@player.name} wins."
            break
          else
            @dealer.recieve_card(@deck.deal)
            puts "Dealer's card is #{@dealer.cards.last.info}"
            puts "Dealer's total is #{@dealer.total}"
          end
        end
      end
    end

    while true
      puts "play again? 1)Yes 2)No"
      again = gets.chomp
      if (again == "1") 
        run
      else
        puts "Thanks for playing."
        break
      end
    end
  end
end
Blackjack.new.run


