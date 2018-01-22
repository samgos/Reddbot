require 'nokogiri'
require 'open-uri'

require 'nokogiri'
require 'open-uri'

fiat = open("https://www.worldcoinindex.com/coin/reddcoin")
document = Nokogiri::HTML(fiat)

usd = document.xpath('/html/body/div[4]/div[3]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]').inner_html

k = usd.gsub(/<\/?span[^>]*>/,"")
k =  k.gsub(/<\/?small[^>]*>/,"")
k = k.gsub(/<\/?div[^>]*>/,"")
k =  k.gsub(/<\/?br[^>]*>/,"")
disp = k.gsub!(/[$]/, '')
print disp
