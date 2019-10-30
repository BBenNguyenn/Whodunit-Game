# CLASS: InteractivePlayer
# REMARKS: What is the purpose of this class?
#   To represent an interactive player.
#-----------------------------------------
class InteractivePlayer < AbstractPlayer

  #------------------------------------------------------
  # setCard
  #
  # PURPOSE:
  #     Puts the card into player's hand and output message
  # PARAMETERS:
  #     Card c -> to be put into hand
  #------------------------------------------------------
  def setCard(c)
    @cards.push(c)
    puts "You received the card "+c.value
  end #setCard


  #------------------------------------------------------
  # canAnswer
  #
  # PURPOSE:
  #     Lists and lets the player choose which card to answer,
  #     automatically answer if there are no or one card
  # PARAMETERS:
  #     index i -> unused
  #     Guess g -> compare hand with guesses
  # Returns: a Card object from the player's hand "@Cards"
  #------------------------------------------------------
  def canAnswer(i, g)
    print "Player #{i} asked you about #{g.to_s}"
    answers = [] #array

    if @cards.include? g.person
      answers.push(g.person)
    end

    if @cards.include? g.place
      answers.push(g.place)
    end

    if @cards.include? g.weapon
      answers.push(g.weapon)
    end

    if answers.length == 0
      puts ", but you couldn't answer"
      return nil
    elsif answers.length == 1
      puts ", but you you only have one card, #{answers[0].to_s}, showed it to them."
      return answers[0]
    else
      puts ". Which do you show?"
      return getUserInputFromArray(answers)
    end
  end #canAnswer


  #------------------------------------------------------
  # getGuess
  #
  # PURPOSE:
  #     Prompts the player for their guess and create it
  #     implementing proper error checking in helper method
  # Returns: a Guess object
  #------------------------------------------------------
  def getGuess
    puts "It is your turn."
    puts "Which person do you want to suggest?"
    guessSuspect = getUserInputFromArray(@suspects)
    puts "Which location do you want to suggest?"
    guessLocation = getUserInputFromArray(@locations)
    puts "Which weapon do you want to suggest?"
    guessWeapon = getUserInputFromArray(@weapons)

    puts "Is this an accusation (Y/[N])?"
    accuse = nil
    while accuse == nil
      input = gets.chomp.to_s
      if input == "Y" or input == "y"
        accuse = true
      elsif input == "N" or input == "n"
        accuse = false
      else
        accuse = nil
        puts "Invalid input, please try again."
      end
    end
    return Guess.new(guessSuspect, guessLocation, guessWeapon, accuse)
  end #getGuess


  #------------------------------------------------------
  # receiveInfo
  #
  # PURPOSE:
  #     Shows the player a card c from player i
  # PARAMETERS:
  #     index i -> for printing
  #     Card c -> for printing
  #------------------------------------------------------
  def receiveInfo(i, c)
    puts "Player #{i} refuted your suggestion by showing you "+c.to_s+"."
  end #receiveInfo


  #------------------------------------------------------
  # getUserInputFromArray
  #
  # PURPOSE:
  #     Prompts player to choose an item from the given array
  #     ensuring proper error checking and re-asking
  # PARAMETERS:
  #     Array arr -> array to prompt
  # Returns: a chosen value from the array
  #------------------------------------------------------
  private
  def getUserInputFromArray(arr)
    if arr.length > 0
      arr.length.times {|x| puts "#{x}: "+arr[x].to_s}
      valid = false
      while not valid
        s = gets.chomp.to_i
        if s >= 0 and s < arr.length
          valid = true
          retVal = arr[s]
        else
          puts "Invalid input, please try again."
        end
      end
    else
      retVal = nil
    end
    return retVal
  end #getUserInputFromArray


end #InteractivePlayer class