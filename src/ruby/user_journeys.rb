require "#{Dir.pwd}/src/ruby/user_journeys/visitor"
require "#{Dir.pwd}/src/ruby/user_journeys/supplier"
require "#{Dir.pwd}/src/ruby/user_journeys/admin"

USER_JOURNEYS = [ { name: "Visitor/User", ujs: VISITOR_UJS },
                  { name: "Supplier",     ujs: SUPPLIER_UJS },
                  { name: "Admin",        ujs: ADMIN_UJS }]