require 'nokogiri'
require 'open-uri'

fiat = open("https://www.worldcoinindex.com/coin/reddcoin")
document = Nokogiri::HTML(fiat)

usd = document.xpath('/html/body/div[4]/div[3]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]').inner_html

k = usd.gsub(/<\/?span[^>]*>/,"")
k =  k.gsub(/<\/?small[^>]*>/,"")
k = k.gsub(/<\/?div[^>]*>/,"")
k =  k.gsub(/<\/?br[^>]*>/,"")
k = k.split()

btc = open("https://bittrex.com/api/v1.1/public/getticker?market=btc-rdd")
documentz = Nokogiri::HTML(btc)
sats = documentz.inner_html
z = sats.gsub(/<\/?span[^>]*>/,"")
z =  z.gsub(/<\/?small[^>]*>/,"")
z = z.gsub(/<\/?div[^>]*>/,"")
z =  z.gsub(/<\/?br[^>]*>/,"")
z =  z.gsub(/<\/?html[^>]*>/,"")
z = z[89..-14]
final = "$#{k[1]} ≈ #{z} ฿"
print final; 
