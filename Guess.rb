# CLASS: Guess
# REMARKS: What is the purpose of this class?
#   To represent and hold a player's guess.
#-----------------------------------------
class Guess
  #isAccusation is a boolean, others are arrays
  attr_reader :person, :place, :weapon, :isAccusation

  #Constructor for a Guess
  def initialize(person, place, weapon, isAccusation)
    @person = person
    @place = place
    @weapon = weapon
    @isAccusation = isAccusation
  end


  #------------------------------------------------------
  # to_s
  # Returns: the guess as a string with proper formatting.
  #------------------------------------------------------
  def to_s
    if isAccusation
      guess = "Accusation: "
    else
      guess = "Suggestion: "
    end
    return guess + "#{person.value} in #{place.value} with the #{weapon.value}."
  end

end #Guess class