APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib'))

require 'guide'
require 'system'
require 'highline/import'

# Start new screen and new guide
guide = Guide.new

# Lauch the program
guide.lauch!
