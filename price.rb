#!/usr/bin/ruby
require 'nokogiri'
require 'open-uri'
url = open( "https://coinmarketcap.com/currencies/reddcoin/")
document = Nokogiri::HTML(url)
btc = document.xpath("/html/body/div[3]/div/div[1]/div[3]/div[2]/small[1]").inner_html
$stdout  = File.open "/home/redd/slack_tipbot/coin_config/btc.rb" ,"a"

p btc

$stdout = STDOUT
$stdout.close



 
