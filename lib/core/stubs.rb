#
# Stubbed out missing pieces
#
#

# FIXME:
# Should auto-generate this so it actually has the correct value...
# However it requires String support to be functional first.
#
__FILE__ = "[filename]"


# Set up the 'main' object
#
# FIXME: This is insufficient. E.g. the object is supposed
# to return 'main' as the textual representation.
#
self = Object.new



# FIXME: This is of course just plain blatantly wrong, but
# the next goal is to get everything to link (and crash...)
# These fall in two categories:
#  - The ones that fails because scoped lookups doesn't
#    yet work
E = 2
Tokens=5
#  - The ones that fails because they haven't been implemented
STDIN= IO.new
STDERR=IO.new
STDOUT = IO.new
Enumerable=8 #Here because modules doesn't work yet

def raise *exp
  puts "ERROR: Exception support not yet implemented"
  puts "ERROR: Arguments to raise were:"
  puts exp.inspect
  puts "ERROR ============="
  exit(1)
end

# FIXME:
%s(defun range (a b)
  (puts "Compiler range construct is not implemented yet")
)

