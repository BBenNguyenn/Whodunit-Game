# CLASS: Player
# REMARKS: What is the purpose of this class?
#   To represent an AI computer opponent player.
#-----------------------------------------
require_relative 'AbstractPlayer'
class Player < AbstractPlayer

  def initializer
    @accuseNext = false
  end #initializer


  #------------------------------------------------------
  # setCard
  #
  # PURPOSE:
  #     Puts the card into this AI player's hand
  #     AI also removes card from list of possible cards
  # PARAMETERS:
  #     Card c -> to be put into hand
  #------------------------------------------------------
  def setCard(c)
    @cards.push(c)
    removeCard(c)
  end #setCard


  #------------------------------------------------------
  # canAnswer
  #
  # PURPOSE:
  #     Determines which card to answer if any,
  #     starting with person, which does not matter I guess
  # PARAMETERS:
  #     index i -> unused
  #     Guess g -> compare hand with guesses
  # Returns: a Card object from the player's hand "@Cards"
  #------------------------------------------------------
  def canAnswer(i, g)
    if @cards.include? g.person
      retVal = g.person
    elsif @cards.include? g.place
      retVal = g.place
    elsif @cards.include? g.weapon
      retVal = g.weapon
    else
      retVal = nil
    end
    return retVal
  end #canAnswer


  #------------------------------------------------------
  # getGuess
  #
  # PURPOSE:
  #     Creates a guess object from AI player's list of
  #     suspect cards (first element)
  #     Determines if AI should accuse or not as well
  # Returns: a Guess object
  #------------------------------------------------------
  def getGuess
    accuse = false
    if @accuseNext ||
        (@suspects.length == 1 and @locations.length == 1 and @weapons.length == 1)
      accuse = true
    end
    return Guess.new(@suspects[0], @locations[0], @weapons[0], accuse)
  end #getGuess


  #------------------------------------------------------
  # receiveInfo
  #
  # PURPOSE:
  #     Removes given card from AI player's list of suspect cards
  # PARAMETERS:
  #     index i -> unused
  #     Card c -> card to remove
  #------------------------------------------------------
  def receiveInfo(i, c)
    removeCard(c)
  end #receiveInfo


  #------------------------------------------------------
  # setAccuseNext
  #
  # PURPOSE:
  #     Used only after a suggestion from the previous
  #     turn was given no answers, meaning suggestion
  #     was correct, so make sure to accuse next turn
  #     regardless of what is in suspects card list
  #------------------------------------------------------
  def setAccuseNext
    @accuseNext = true;
  end #setAccuseNext


  #------------------------------------------------------
  # removeCard
  #
  # PURPOSE:
  #     Implementation of removing a given card from
  #     AI player's list of suspect cards
  #     ensuring from the correct card type list
  # PARAMETERS:
  #     Card c -> card to remove
  #------------------------------------------------------
  private
  def removeCard(c)
    if c.type == :person
      @suspects.delete(c)
    elsif c.type == :place
      @locations.delete(c)
    elsif c.type == :weapon
      @weapons.delete(c)
    else
      puts "ERROR, invalid card type" #should never reach
    end
  end #removeCard


end #Player class