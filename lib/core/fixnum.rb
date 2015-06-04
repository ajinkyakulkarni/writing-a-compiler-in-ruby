
class Fixnum < Integer

  def initialize
    %s(assign @value 0)
  end

  def % other
#    %s(printf "%i\n" (callm other __get_raw))
    %s(assign r (callm other __get_raw))
    %s(assign m (mod @value r))

    %s(if (eq (gt m 0) (lt r 0))
         (assign m (add m r)))
    %s(__get_fixnum m)
  end

  def __set_raw(value)
    @value = value
  end

  def __get_raw
    @value
  end

  def to_s
    %s(let (buf)
       (assign buf (malloc 16))
       (snprintf buf 16 "%ld" @value)
       (__get_string buf)
       )
  end

  def inspect
    to_s
  end

  def chr
   %s(let (buf)
       (assign buf (malloc 2))
       (snprintf buf 2 "%c" @value)
       (__get_string buf)
       )
  end

  def + other
    %s(call __get_fixnum ((add @value (callm other __get_raw))))
  end

  def - other
    %s(call __get_fixnum ((sub @value (callm other __get_raw))))
  end

  def <= other
    %s(if (le @value (callm other __get_raw)) true false)
  end

  def == other
    if other.nil?
      return false 
    end
    %s(if (eq @value (callm other __get_raw)) true false)
  end

  # FIXME: I don't know why '!' seems to get an argument...
  def ! *args
    false
  end

  def != other
    %s(if (ne @value (callm other __get_raw)) true false)
  end

  def < other
    %s(if (lt @value (callm other __get_raw)) true false)
  end

  def > other
    %s(if (gt @value (callm other __get_raw)) true false)
  end

  def >= other
    %s(if (ge @value (callm other __get_raw)) true false)
  end

  def div other
    %s(call __get_fixnum ((div @value (callm other __get_raw))))
  end

  def mul other
    %s(call __get_fixnum ((mul @value (callm other __get_raw))))
  end

  # These two definitions are only acceptable temporarily,
  # because we will for now only deal with integers

  def * other
    mul(other)
  end

  def / other
    div(other)
  end

  def ord
    self
  end
  
end


%s(defun __get_fixnum (val) (let (num)
  (assign num (callm Fixnum __alloc))
  (callm num __set_raw (val))
  num
))
