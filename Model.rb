#-----------------------------------------
# REMARKS: What is the purpose of this program?
#   To implement the game "Whodunit", which is a
#   simplified version of "Clue" with one interactive
#   player vs an inputted number of AI players.
#-----------------------------------------
class Model

  #Constructor for the Model, ie the game's base
  def initialize(people, places, weapons)
    @suspects = people
    @locations = places
    @weapons = weapons
  end


  #------------------------------------------------------
  # setPlayers
  #
  # PURPOSE:
  #     To instantiate and assign ID's to each player,
  #     providing them with lists of all cards.
  #     Also prints out all cards initially.
  # PARAMETERS:
  #     Array players -> list of all players of both types
  #------------------------------------------------------
  def setPlayers(players)
    @players = players # no need to clone since only one model

    #pass setup information from main to model to all players
    for i in 0...players.size
      @players[i].setup(players.length, i, @suspects, @locations, @weapons)
    end

    #print out all cards in game
    puts "Here are the names of all the suspects:"
    puts @suspects.cycle(1){|x| print x.value + ", "}
    puts "Here are the locations:"
    puts @locations.cycle(1){|x| print x.value + ", "}
    puts "Here are the weapons:"
    puts @weapons.cycle(1){|x| print x.value + ", "}
  end #setPlayers


  #------------------------------------------------------
  # setupCards
  #
  # PURPOSE:
  #     Shuffles the cards and distributes them to players
  #     Also choose the answer cards in the process.
  #------------------------------------------------------
  def setupCards
    #shuffle individual card decks
    @suspects.shuffle!
    @locations.shuffle!
    @weapons.shuffle!

    #set answer cards
    @answerCards = Array.new
    @answerCards.push(@suspects.pop)
    @answerCards.push(@locations.pop)
    @answerCards.push(@weapons.pop)
    puts " \nANSWERS:  "+"#{@answerCards.cycle(1){|x| print "#{x.value} , "}}"

    #group cards then shuffle again
    @allCards = @suspects+@locations+@weapons
    @allCards.shuffle!

    # distribute cards until deck is empty
    i = 0
    while not @allCards.empty?
      @players[i].setCard(@allCards.pop)
      i = (i+1)%@players.length
    end #while not @allCards.empty?
  end #setupCards


  #------------------------------------------------------
  # play
  #
  # PURPOSE:
  #     To implement the core logic of the game,
  #     Determines who's turn it is, what they can do,
  #     Player winning conditions, most ALL public print outs.
  #------------------------------------------------------
  def play
    numActivePlayers = @players.length
    gameOver = false
    turn = 0

    while not gameOver
      if @players[turn].inGame

        #GUESS ONLY IF NOT ABOUT TO WIN FROM BEING LAST PLAYER
        if numActivePlayers > 1
          puts "Current turn: #{turn}"
          currGuess = @players[turn].getGuess
          puts "Player #{turn}: "+currGuess.to_s
        else
          puts "Player #{turn} is the last player standing."
        end

        #CORRECT ACCUSATION OR LAST PLAYER STANDING, WIN GAME
        if numActivePlayers <= 1 or (currGuess.isAccusation and
            @answerCards.include? currGuess.person and
            @answerCards.include? currGuess.place and
            @answerCards.include? currGuess.weapon)
          gameOver = true
          puts "Player #{turn} won the game."

        #WRONG ACCUSATION, OUT OF GAME
        elsif currGuess.isAccusation
          @players[turn].outOfGame
          numActivePlayers -= 1
          puts "Player #{turn} made a bad accusation and was removed from the game."

        else #SUGGESTION CASE
          answered = false
          i = (turn+1)%@players.length
          loop do
            puts "Asking player #{i}"
            cardGiven = @players[i].canAnswer(turn, currGuess)

            if cardGiven
              @players[turn].receiveInfo(i, cardGiven)
              answered = true
              puts "Player #{i} answered."
            end
            i = (i+1)%@players.length

          break if i == turn or answered
          end #loop do

          if not answered
            #Player AI will know that this guess should be accusation next turn
            if @players[turn].is_a? Player
              puts "No one could answer."
              @players[turn].setAccuseNext
            else
              puts "No one could refute your suggestion."
            end #if @players[turn].is_a? Player
          end #if not answered
        end #if currGuess.isAccusation and etc

      end #if @players[turn].inGame
      turn = (turn+1)%@players.length
    end #while not gameOver

  end #play


end #Model class