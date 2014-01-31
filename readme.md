# UXfu

User experience framework for constructing interactive digital:

* User profiles :TODO
* User journeys :WIP
* Wireframes
* Prototypes

***

# Requirements

* Ruby 2.0 and above
* To install Ruby gems: run `$ bundle install`
* Node (for javascript tests)
* 

***

# Start server

* Run `$ shotgun --server=puma config.ru`

***

# Tests

To test files install mocha and chai globally `$ sudo npm install -g mocha chai` then run `$ mocha src/tests/js/myTestFile.js`

***

# Coffeescript

* Source files in `./src/coffee`
* Tests in `./src/tests/coffee`
* Run `$ guard` to automatically compile coffeescript into javascript as you save