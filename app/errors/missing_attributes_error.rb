class MissingAttributesError < StandardError
  
  def initialize(key)
    super("Missing Argument in params #{key}")
  end
end