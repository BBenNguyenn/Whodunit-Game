# CLASS: Card
# REMARKS: What is the purpose of this class?
#   To represent a card in the game.
#-----------------------------------------
class Card
  #value is a string
  attr_reader :type, :value

  #Constructor for a Card
  def initialize(type, value)
    @type = type
    @value = value
  end


  #------------------------------------------------------
  # to_s
  # Returns: the value as a string
  #------------------------------------------------------
  def to_s
    return value
  end

end #Card class