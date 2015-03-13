
class Object
  # At this point we have a "fixup to make as part of bootstrapping:
  #
  #  Class was created *before* Object existed, which means it is not linked into the
  #  subclasses array. As a result, unless we do this, Class will not inherit methods
  #  that are subsquently added to Object below. This *must* be the first thing to happen
  #  in Object, before defining any methods etc:
  #
  %s(assign (index self 4) Class)

  # FIXME: Should include "Kernel" here

  def initialize
    # Default. Empty on purpose
  end

  def class
    @__class__
  end

  def inspect
    %s(assign buf (malloc 20))
    %s(snprintf buf 20 "%p" self)
    %s(assign buf (__get_string buf))
    "#<#{self.class.name}:#{buf}>"
  end

  def == other
    %s(if (eq self other) true false)
  end

  def nil?
    false
  end

  def respond_to?
    puts "Object#respond_to not implemented"
  end

  # FIXME: This will not handle eigenclasses correctly.
  def is_a?(c)
    k = self.class
    while k != c && k != Object
      k = k.superclass
    end

    return (k == c)
  end

  # FIXME: Private
  def send sym, *args
    __send__(sym, *args)
  end

  def __send__ sym, *args
    self.class.__send_for_obj__(self,sym,*__splat)
  end

  # FIXME: Belongs in Kernel
# FIXME: Add splat support for s-expressions / call so that
# the below works
#  def printf format, *args
#    %s(printf format (rest args))
#  end

  # FIXME: Belongs in Kernel
  def puts *str
    %s(assign na (__get_fixnum numargs))

    if na == 2
      %s(puts "")
      return
    end

    na = na - 2
    i = 0
    while i < na
      %s(assign raw (index str (callm i __get_raw)))
      %s(assign hr (if (ne raw 0) true false))
      if hr
        raw = raw.to_s.__get_raw
        %s(if (ne raw 0) (puts raw))
      else
        %s(puts "")
      end
      i = i + 1
    end
    nil
  end

  def print *str
    %s(assign na (__get_fixnum numargs))
    
    if na == 2
      %s(printf "nil")
      return
    end

    na = na - 2
    i = 0
    while i < na
      %s(assign raw (index str (callm i __get_raw)))
      raw = raw.to_s.__get_raw
      %s(if raw (printf "%s" raw))
      i = i + 1
    end
  end
end
