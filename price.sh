 lynx -base -source 'https://coinmarketcap.com/currencies/reddcoin/' | hxnormalize -x | \
    hxselect -c -s '\n' "body > div.container > div > div.col-xs-12.col-sm-12.col-md-12.col-lg-10 > div:nth-child(5) > div.col-xs-6.col-sm-8.col-md-4.text-left > small.text-gray"
