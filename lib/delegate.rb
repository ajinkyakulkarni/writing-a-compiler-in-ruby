
class Delegate
end

#
# FIXME
# Very basic initial implementation
# of SimpleDelegator. Note that according to
# the docs, it is incorrect for the methods
# to change if __setobj__ is called, which
# implies forwarding methods are created,
# rather than relying on method_missing
#
class SimpleDelegator
  def initialize ob
    @ob = ob
  end

  # FIXME: Cleaner way is to remove default implementations
  def inspect
    @ob.inspect
  end

  def __getobj__
    @ob
  end

  def __setobj__ ob
    @ob = ob
  end

  def [] index
    @ob[index]
  end

  def method_missing sym, *args
    @ob.send(sym,*args)
  end
end
