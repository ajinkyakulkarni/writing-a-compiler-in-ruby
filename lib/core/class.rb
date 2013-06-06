# size <= ssize *always* or something is severely wrong.
%s(defun __new_class_object (size superclass ssize)
  (let (ob i)
   (assign ob (malloc (mul size 4))) # Assumes 32 bit
   (assign i 1)
 #  %s(printf "class object: %p (%d bytes) / Class: %p / super: %p / size: %d\n" ob size Class superclass ssize)
  (while (le i ssize) (do
       (assign (index ob i) (index superclass i))
       (assign i (add i 1))
  ))
  (while (lt i size) (do
       # Installing a pointer to a thunk to method_missing
       # that adds a symbol matching the vtable entry as the 
       # first argument and then jumps straight into __method_missing
       (assign (index ob i) (index __base_vtable i))
       (assign i (add i 1))
  ))
  (assign (index ob 0) Class)
  ob
))

# FIXME: This only works correctly for the initial
# class definition. On subsequent re-opens of the class
# it will fail to correctly propagate vtable changes 
# downwards in the class hierarchy if the class has
# since been overloaded.
%s(defun __set_vtable (vtable off ptr)
  (assign (index vtable off) ptr)
)

class Class

  def new *rest
    # @instance_size is generated by the compiler. YES, it is meant to be
    # an instance var, not a class var
    size = @instance_size
    %s(assign ob (malloc (mul size 4)))
    %s(assign (index ob 0) self)
    ob.initialize(*rest)
    ob
  end

  # FIXME
  # &block will be a "bare" %s(lambda) (that needs to be implemented),
  # define_method needs to attach that to the vtable (for now) and/or
  # to a hash table for "overflow" (methods lacking vtable slots).
  # This requires a painful decision:
  #
  # - To type-tag Symbol or not to type-tag
  #
  # It also means adding a function to look up a vtable offset from
  # a symbol, which effectively means a simple hash table implementation
  #
  def define_method sym, &block
    %s(printf "define_method %s\n" (callm (callm sym to_s) __get_raw))
  end

  # FIXME: Should handle multiple symbols
  def attr_accessor sym
    attr_reader sym
    attr_writer sym
  end
  
  def attr_reader sym
    %s(printf "attr_reader %s\n" (callm (callm sym to_s) __get_raw))
    define_method sym do
#       %s(ivar self sym) # FIXME: Create the "ivar" s-exp directive.
    end
  end

  def attr_writer sym
    %s(printf "attr_writer %s\n" (callm (callm sym to_s) __get_raw))
    # FIXME: Ouch: Requires both String, string interpolation and String#to_sym to
    # be implemented on top of define_method and "ivar"
    define_method "#{sym.to_s}=".to_sym do |val|
#      %s(assign (ivar self sym) val)
    end
  end
end

