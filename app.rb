require 'rubygems'
require 'sinatra'
require 'json'
require "ostruct"
require "#{Dir.pwd}/src/ruby/user_journeys"

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV["THE_KNOT_UX_LOGIN"] && password == ENV["THE_KNOT_UX_PW"]
end

###### --------------- ###### MONKEY PATCH ###### --------------- ######

class String
  def to_url
    self.downcase.gsub("\s", "-").gsub("&", "and")
  end

  def to_un_url
    self.capitalize.gsub("-", "\s").gsub("and", "&")
  end
end

###### --------------- ###### NAV IA ###### --------------- ######

pre_wedding       = { title: "Pre-wedding", items:  ["Proposal", "Rings", "Engagement", "Hens night", "Bucks night", "Health & fitness"]}
reception         = { title: "Reception & ceremony", items: ["Decor", "Flowers", "Invitations & stationary", "Cakes", "Music & dancing", "Guest list", "Photography & video", "Favours", "Vows & readings", "Speeches", "Registry", "Destination weddings", "Food & drinks"]}
bride             = { title: "Bride, dress & party", items: ["Wedding dress", "Hair & make up", "Accessories", "Bridal party", "Health & fitness"] }
other             = { title: "Other", items: ["Real weddings", "Honeymoon"] }
inspiration_items = { title: "Inspiration", categories: [ pre_wedding, reception, bride, other ] }

pre_wedding_2     = { title: "Pre-wedding", items: ["Planning (26)", "Invitations (20)", "Wedding prep & events (13)", "Engagement (18)"]}
reception_2       = { title: "Reception & ceremony", items: ["Reception (119)", "Photo & video (115)", "Ceremony (64)", "Presents & Registry (4)"]}
bride_2           = { title: "Bride, dress & party", items: ["Dresses & fashion (96)", "Beauty (20)", "Gown cleaning & preservation (6)"]}
post              = { title: "Post wedding", items: ["Honeymoon & travel (37)", ""]}
supplier_items    = { title: "Suppliers", categories: [ pre_wedding_2, reception_2, bride_2, post ] }

nav               = { nav_items: [ inspiration_items, supplier_items ] }

nav_comments      = { title: "Comments (24)", items: [ "Pending (24)", "Approved (23,456)" ]  }
nav_posts         = { title: "Posts", items: [ "Create new", "My unpublished (3)", "My published (123)", "All unpublished (30)", "All published (1,230)" ] }

admin_nav         = [ nav_posts, nav_comments ]

###### --------------- ###### USER JOURNEYS ###### --------------- ######

USER_JOURNEYS_LENGTH = USER_JOURNEYS.inject(0) { |sum, u| sum + u.fetch(:ujs).length }

###### --------------- ###### CONTENT ###### --------------- ######

class Content < OpenStruct
  attr_accessor :title, :meta, :desc, :cta
end

myth_busted = Content.new(title: "5 Wedding Guest Myths — Busted", 
                          author: "Miles Stiverson",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Article",
                          desc: "Here are five commonly held beliefs that are really more fiction than fact.",
                          cta: "Read now")

latifah_wed = Content.new(title: "33 Weddings Officiated by Queen Latifah at the Grammys",
                          author: "John Smith",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Blog",
                          desc: "The biggest surprise at the Grammy’s this year was much better than the time Kanye West interrupted.",
                          cta: "Read now")

string_bistro = Content.new(title: "7 Places To Use String Bistro Lights At Your Wedding",
                          author: "Bridgett Clegg",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Blog",
                          desc: "Talk about mood lighting! Decorative bistro lights, also called string or market or fairy lights.",
                          cta: "Read now")

new_rules = Content.new(title: "The New Rules of Wedding Etiquette",
                          author: "Simone Hill",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Article",
                          desc: "It’s inevitable that you’ll spread the excitement of your wedding to everyone in your social media network.",
                          cta: "Read now")

bargin_dest = Content.new(title: "10 Best Bargain Honeymoon Destinations",
                          author: "Nancy Rones",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Article",
                          desc: "Create big memories on a small honeymoon budget.",
                          cta: "Read now")

oahu_hawaii = Content.new(title: "Destination Guide: O’ahu, Hawaii",
                          author: "Juliette Winter",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Article",
                          desc: "Looking for paradise on earth? Try O’ahu.",
                          cta: "Read now")

whos_invited = Content.new(title: "Who’s Invited?",
                          author: "The Knot",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Article",
                          desc: "Question: Who gets invited to the engagement party?",
                          cta: "Read answer")

luv_bridal = Content.new(title: "Luv Bridal Wedding Dress Collection",
                          author: "Luv Bridal",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Photo gallery",
                          desc: "10 gorgeous gowns by Luv Bridal",
                          cta: "View gallery")

bridal_fashion = Content.new(title: "The A-Z Of Bridal Fashion",
                          author: "Luv Bridal",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Photo gallery",
                          desc: "More than likely you’ve been dreaming of your wedding day style since you were a little girl.",
                          cta: "View gallery")

tessa_and_nate = Content.new(title: "Tessa and Nate, VIC",
                          author: "Luv Bridal",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Video",
                          desc: "A stunning Melbourne summer wedding (you might recognise Tessa from Home and Away!",
                          cta: "View gallery")

case_study = Content.new(title: "Our leads doubled!",
                          author: "Luv Bridal",
                          posted: "#{2 + Random.rand(13) } hours ago",
                          content_type: "Case study",
                          desc: "Learn how Luv Bridal doubled their customer leads.",
                          cta: "View case study")

all_content = [ bargin_dest, new_rules, string_bistro, latifah_wed, myth_busted, tessa_and_nate, bridal_fashion, luv_bridal, whos_invited, oahu_hawaii, tessa_and_nate ]

def inspiration_content_generator(name)
  Content.new(title: "#{name} content",
    author: "Someone special",
    posted: "#{2 + Random.rand(13) } hours ago",
    content_type: ["Photo gallery", "Supplier", "Blog"].sample,
    desc: "10 #{name.to_un_url}s to help you #{name.downcase.to_un_url} at your #{name.downcase.to_un_url}.",
    cta: "Read more")
end

def supplier_content_generator(name)
  Content.new(title: "#{name} widgets",
    author: "Someone special",
    posted: "#{2 + Random.rand(4) } years ago",
    content_type: "Supplier",
    desc: "The best wedding widgets in town.",
    cta: "Contact supplier")
end

###### --------------- ###### SUPPLIER CONTENT ###### --------------- ######

elegant_resort = Content.new(title: "Elegant Resorts & Villas",
                          author: "Elegant",
                          posted: "1.5 yrs ago",
                          content_type: "Suppliers",
                          desc: "Elegant Resorts & Villas specialises in Island Escapes; Tahiti & Bora Bora, Fiji Islands, Maldives & Mauritius.",
                          cta: "View supplier")


###### --------------- ###### ORDER BY FILTER ###### --------------- ######

def popover_html(content)
  html = ""
  content.each_with_index do |content, index|
    html << "<ul>" if index == 0
    html << "<li><a href='#'>#{content}</a></li>"
    html << "</ul>" if index == content.length
  end
  html
end

content_types = ["all", "article", "photo gallery", "blog", "video", "comment"]
popularity_types = ["any", "views", "comments", "look books", "shares"]
theme_types = ["any", "DIY", "Classic", "Winter", "Summer", "Etc"]

order_by_content = { content_types: popover_html(content_types),
                     popularity_types: popover_html(popularity_types),
                     theme_types: popover_html(theme_types) }

destination = ["NSW", "VIC", "SA"]
guests = ["20", "40", "60"]
budget = ["under $40", "$40-80", "$10,0000"]

supplier_order_by_content = { theme_types: popover_html(theme_types),
                     destination: popover_html(destination),
                     guests: popover_html(guests),
                     budget: popover_html(budget) }

###### --------------- ###### VISITOR WIRES ###### --------------- ######

get '/home' do
  erb :index, locals: { 
    content: 'home',
    nav: nav,
    
    title: 'Visitor home',
    title_content: [ myth_busted.to_h, oahu_hawaii.to_h, string_bistro.to_h ],
    card_content: [ luv_bridal.to_h, bargin_dest.to_h, whos_invited.to_h ]
  }
end

get '/inspiration/:category_name' do
  category = params[:category_name].capitalize
  content  = inspiration_content_generator(category).to_h

  erb :index, locals: { 
    content: 'inspiration_index',
    nav: nav,
    
    title: category,
    title_content: [ content, content, content ],
    card_content: content,
    order_by_content: order_by_content
  }
end

get "/suppliers/:category_name" do
  category = params[:category_name].split("-")[0].to_un_url.capitalize
  count    = params[:category_name].split("-")[1]
  content  = supplier_content_generator(category).to_h

  erb :index, locals: {
    content: "supplier_index",
    nav: nav,
    title: category,
    count: count,
    card_content: content,
    title_content: [elegant_resort.to_h, elegant_resort.to_h],
    order_by_content: supplier_order_by_content
  }
end

get "/suppliers/listings/:name" do
  name = params[:name]

  erb :index, locals: {
    content: "supplier_listing_show",
    nav: nav,
    title: name
  }
end

get '/content/:title' do
  title = params[:title].to_un_url
  erb :index, locals: { 
    content: 'content_show',
    nav: nav,
    title: title,
    card_content: [ elegant_resort.to_h, luv_bridal.to_h, bargin_dest.to_h ]
  }
end

get '/tools/look-book' do
  themes = ["Classic", "Formal", "DIY", "Beach", "Summer", "Spring", "Autumn", "Winter", "Gatsby", "Star Wars", "Under Water", "Circ De Soleil"]
  erb :index, locals: {
    content: 'look_book',
    nav: nav,
    title: 'Look Book',
    cards: [ elegant_resort.to_h, bargin_dest.to_h ],
    themes: themes
  }
end

get "/tools/guest-manager" do
  erb :index, locals: {
    content: 'guest_manager',
    nav: nav,
    title: 'Guest manager'
  }
end

###### --------------- ###### SUPPLIER WIRES ###### --------------- ######

get "/advertisers" do
  erb :index, locals: {
    content: 'advertisers',
    nav: nav,
    title: 'Home',
    card: elegant_resort.to_h
  }
end

get "/advertisers/about" do
  erb :index, locals: {
    content: 'advertisers_about',
    nav: nav,
    title: 'Advertisers | About',
    card_content: case_study.to_h
  }
end

get "/advertisers/plans" do
  erb :index, locals: {
    content: 'advertisers_plans',
    nav: nav,
    title: 'Advertisers | Plans'
  }
end

get '/advertisers/new/listing' do
  erb :index, locals: {
    content: 'advertisers_new_listing',
    nav: nav,
    title: 'New listing'
  }
end

get "/advertisers/messages" do
  erb :index, locals: {
    content: 'advertisers_messages',
    nav: nav,
    title: 'Messages [7]'
  }
end

###### --------------- ###### ADMIN WIRES ###### --------------- ######

get "/admin/home" do
  erb :index, locals: {
    content: "admin_home",
    nav: admin_nav,
    title: "Admin"
  }
end

###### --------------- ###### UX PAGES ###### --------------- ######

get '/' do
  erb :index, locals: {
    content: 'project',
    title: 'The Knot UX',
    uj_length: USER_JOURNEYS_LENGTH
  }
end

get '/strategy' do
  erb :index, locals: { content: 'ux_strategy',  title: 'UX Strategy' }
end

get '/user_journeys' do
	erb :index, locals: {
    content:       'user_journeys',
    user_journeys: USER_JOURNEYS,
    uj_length:     USER_JOURNEYS_LENGTH,
    title:         "User Journeys"
  }
end