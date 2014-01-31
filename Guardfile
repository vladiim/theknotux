# Global variables

COFFEE = 'coffeescript'
INPUT  = 'src/coffee'
OUTPUT = 'public/js'

INPUT_TEST  = 'src/tests/coffee'
OUTPUT_TEST = 'src/tests/js'

# Installed by guard-coffeescript

guard COFFEE, input: INPUT,      output: OUTPUT
guard COFFEE, input: INPUT_TEST, output: OUTPUT_TEST

# Installed by guard-mocha-node

# Run mocha when a .js file changes
#

# guard "mocha-node", mocha_bin: File.expand_path(File.dirname(__FILE__) + "/node_modules/mocha/bin/mocha") do
#   watch('./src/tests/js/*')
#   watch('./public/js/*')
# end