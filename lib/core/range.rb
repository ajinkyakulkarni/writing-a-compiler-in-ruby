
# FIXME
# Initial implementation
# This implementation assumes simple ordering
class Range
  def initialize _min, _max
    @min = _min
    @max = _max
  end

  # FIXME: This is hopelessly inadequate, but
  # tolerable for the case where we only use integer
  # ranges
  def member? val
    if !val
      return false
    end
    return val >= @min && val <= @max
  end
end
