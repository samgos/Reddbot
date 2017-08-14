
#!/usr/bin/ruby
module Reddcoin
  PERFORM_ERROR = 'Invalid crypto command.'
  BALANCE_REPLY_PRETEXT = 'Your current balance is:'
  CURRENCY_ICON = ' RDD :reddcoin:'
  WEALTHY_UPPER_BOUND = 10000
  WEALTHY_UPPER_BOUND_POSTTEXT = ' Rolling in Redd!'
  WEALTHY_UPPER_BOUND_EMOJI = ':reddcoin:'
  BALANCE_REPLY_POSTTEXT = ' '
  DEPOSIT_PRETEXT = 'Enter an integer for deposit ->'
  DEPOSIT_POSTTEXT = '<- this is your depositing address.'
  TIP_ERROR_TEXT = 'Please say -> tip @username amount'
  TIP_PRETEXT = 'Give a little to get a little, they do say?'
  TIP_POSTTEXT1 = 'https://live.reddcoin.com/tx/'
  TIP_POSTTEXT2 = ' |View transaction on Reddsight - Block Explorer.'
  WITHDRAW_TEXT = 'Tired of being the charitable type!?'
  WITHDRAW_ICON = ':reddcoin:'
  NETWORKINFO_ICON = ':bar_chart:'
  TOO_POOR_TEXT = 'Insufficient funds.'
  PRICE_PRE = 'The current price of Reddcoin is: '
  HELP = 'Commands are used by saying reddbot and one of the following: deposit, balance, tip, withdraw, leaderboard,  price, chart or about.'
  NO_PURPOSE_LOWER_BOUND_TEXT = 'You call that a tip?'
  NO_PURPOSE_LOWER_BOUND = 0.000001
  HI = 'Greetings'
  GREETING = ', I hope you are having a good day.'
  RANDOMIZED_EMOJI = ':reddcoin:'
  NETWORK = 'reddcoin'
  ABOUT = 'Compiled by @gozzy, view source code on '
  ABOUT2 = 'https://github.com/samgos/reddbot'
  FEE = 'Attempt compensating for tx fee.'
  SYM = 'BTC :bitcoin:'
  BTC = 'Which is approximately equal to '
end
