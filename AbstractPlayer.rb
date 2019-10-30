# CLASS: AbstractPlayer
# REMARKS: What is the purpose of this class?
#   To represent both player types to inherit from.
#-----------------------------------------
class AbstractPlayer

  # :cards is an array
  # :inGame is a boolean
  attr_reader :cards, :inGame

  #Initializer should never be called
  def AbstractPlayer.new(*args)
    @@numPlayers = 0
    if self == AbstractPlayer
      raise "AbstractPlayer is an abstract class and cannot be instantiated"
    else
      super
    end
  end


  #------------------------------------------------------
  # setup
  #
  # PURPOSE:
  #     To give players information about the game and
  #     instantiate key instance variables
  # PARAMETERS:
  #     int numPlayers -> number of players in game
  #     int myIndex -> given player ID
  #     Array suspects -> list of people suspects
  #     Array locations -> list of place locations
  #     Array weapons -> list of weapons
  #------------------------------------------------------
  def setup(numPlayers, myIndex, suspects, locations, weapons)
    @@numPlayers = numPlayers
    @myIndex = myIndex
    @suspects = suspects.clone
    @locations = locations.clone
    @weapons = weapons.clone
    @cards = Array.new
    @inGame = true
  end #setup

  #------------------------------------------------------
  # outOfGame
  #
  # PURPOSE:
  #     Used to indicate that this player is out of the game
  #     ie has made a wrong accusation. They can still
  #     answer, but not guess (in play method logic).
  #     *Used to skip over them in play method logic.*
  #------------------------------------------------------
  def outOfGame
    @inGame = false
  end #outOfGame


  #PLEASE SEE CONCRETE CLASSES WITH DETAILS
  def setCard(c)
    raise "AbstractPlayer is an abstract class"
  end

  #PLEASE SEE CONCRETE CLASSES WITH DETAILS
  def canAnswer(i, g)
    raise "AbstractPlayer is an abstract class"
  end

  #PLEASE SEE CONCRETE CLASSES WITH DETAILS
  def getGuess
    raise "AbstractPlayer is an abstract class"
  end

  #PLEASE SEE CONCRETE CLASSES WITH DETAILS
  def receiveInfo(i, c)
    raise "AbstractPlayer is an abstract class"
  end

end #AbstractPlayer abstract class