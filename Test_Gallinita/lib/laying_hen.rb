class Egg
  # Initializes a new Egg with hatched hours +hatched_hours+
  def initialize(hatched_hours)
    @hatched_hours = hatched_hours
  end

  # Return +true+ if hatched hours is greater than 3, +false+ otherwise
  def rotten?
   @hatched_hours > 3 ? true : false
  end
end

class LayingHen 

  attr_reader :age
  def initialize
    @age = 0
    @eggs = 0
    @hatched_hours = 0
  end

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @age += 1
    @eggs = 4 if @age > 3
  end

  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
    @eggs > 0 ? true : false
  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?
    # egg-picking logic goes here
    @eggs -= 1
    Egg.new(@hatched_hours)
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise.
  # The max age for a hen to lay eggs is 10 
  def old?
    @age > 10 ? true : false
  end

  def increase_hatched_hour(hours)
    if hours.class == Fixnum
      @hatched_hours = hours
    else
      raise ArgumentError
    end
  end
end

class NoEggsError < StandardError; end