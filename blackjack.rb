player = []
dealer = []

def suffleDeck 
  symbols = ["Diamond", "Heart", "Clover", "Spade"]
  cardNum = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K"]
  deck = []
  symbols.each do |s|
    cardNum.each do |c|
      deck << [s, c]
    end
  end
  deck.shuffle!
  return deck
end

deck = suffleDeck

2.times do
  #player << deck.pop()
end

player = [["Diamond", "A"], ["Diamond", "6"]]

2.times do
  dealer << deck.pop()
end

def total(cards)
  t = 0 
  ace = 0
  cards.each do |c|
    if (c[1] == "J") || (c[1] == "Q") || (c[1] == "K")
      t = t + 10
    elsif (c[1] == "A")
      ace = ace + 1
      #if (t + 11) > 21
       # t = t + 1
      #else 
       # t = t +11
      #end
    else
      t = t + c[1].to_i
    end
  end
  ace.times {
    if (t + 11) > 21
     t = t + 1
    else 
     t = t +11
    end
  }
  return t   
end

playerTotal = total(player)
dealerTotal = total(dealer)

puts "#{player}"
puts "#{dealer}"

puts "Your total is #{playerTotal}"
puts "Dealer's total is #{dealerTotal}"

if (playerTotal == 21)
  puts "You win!! You have BlackJack!!"
elsif (dealerTotal == 21) 
  puts "Dealer wins!! Dealer has BlackJack!!"
else
  # Neither has BlasckJack. Let's play!!
  while true 
    puts "1)hit? or 2)stay?"
    status = gets.chomp
    if status == "2"
      break
    else
      player << deck.pop()
      playerTotal = total(player)
      puts "Your cards #{player}"
      puts "Your total is #{playerTotal}"
      if playerTotal > 21
        puts "You busted!! You lost"
        break
      end
    end
  end

  if playerTotal <= 21 
    puts "Now, It is Dealers turn"
    while true 
      if (dealerTotal > 16) && (dealerTotal <= 21)
        puts "Dealer stops"
        puts "You win!!" if (playerTotal > dealerTotal)
        puts "You loose!!" if (playerTotal < dealerTotal)
        puts "You draw!!" if (playerTotal == dealerTotal)
        break
      elsif (dealerTotal > 21)
        puts "Dealer busted!! you win"
        break
      else
        dealer << deck.pop()
        dealerTotal = total(dealer)
        puts "Dealer's cards #{dealer}"
        puts "Dealer's total is #{dealerTotal}"
      end
    end
  end
end
    







