#Provided by instructor

require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

puts("Welcome to \"whodunnit?\"")
people = [
    Card.new(:person,"Prof. Bo"),
    Card.new(:person,"Prof. Do"),
    Card.new(:person,"Prof. Ca"),
    Card.new(:person,"Prof. Gu"),
    Card.new(:person,"Prof. Du"),
    Card.new(:person,"Prof. Li"),
    Card.new(:person,"Prof. Mi"),
    Card.new(:person,"Prof. Wa"),
    Card.new(:person,"Prof. Br")

]

places = [
    Card.new(:place,"COMP 150 course"),
    Card.new(:place,"COMP 160 course"),
    Card.new(:place,"COMP 140 course"),
    Card.new(:place,"COMP 280 course"),
    Card.new(:place,"COMP 080 course")
]

weapons = [
    Card.new(:weapon,"midterm"),
    Card.new(:weapon,"final exam"),
    Card.new(:weapon,"assignment"),
    Card.new(:weapon,"lab"),
]

o = Model.new(people,places,weapons)
puts("How many computer opponents would you like?")
numPlayers = gets.chomp.to_i

players = Array.new(numPlayers+1)
(numPlayers).times { |i| players[i] = Player.new() }
players[numPlayers] = InteractivePlayer.new()

puts("Setting up players..")
o.setPlayers(players)
puts("Dealing cards..")
o.setupCards()
puts("Playing...")
o.play()
puts ("Game over")