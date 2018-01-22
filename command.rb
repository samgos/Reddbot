#!/usr/bin/ruby
require 'bitcoin-client'
require 'net/http'
require 'sinatra'
require 'json'

Dir['./coin_config/*.rb'].each {|file| require file }
require './bitcoin_client_extensions.rb'
class Command
  attr_accessor  :result, :action, :user_name, :icon_emoji , :channel
  ACTIONS = %w(leaderboard balance chart rain deposit tip withdraw about price help hi commands)
  def initialize(slack_params)
    @coin_config_module = Kernel.const_get ENV['COIN'].capitalize
    text = slack_params['text']
    @params = text.split(/\s+/)
    raise "REDDCOIN IS THE BEST" unless @params.shift == slack_params['trigger_word']
    @user_name = slack_params['user_name']
    @user_id = slack_params['user_id']
    @action = @params.shift
    @result = {}
    @price = `ruby price.rb `
    end

 def perform
    if ACTIONS.include?(@action)
      self.send("#{@action}".to_sym)
    else
      raise @coin_config_module::PERFORM_ERROR
    end
  end

  def client
    @client ||= Bitcoin::Client.local
  end

 def balance
    balance = client.getbalance(@user_id)
    pricei = `ruby usd.rb`
    x = ((balance*pricei.to_f).round(3)).to_s

    @result[:text] = "@#{@user_name} #{@coin_config_module::BALANCE_REPLY_PRETEXT} #{balance}#{@coin_config_module::CURRENCY_ICON} ≈ $#{x} "
    if balance > @coin_config_module::WEALTHY_UPPER_BOUND
      @result[:text] += @coin_config_module::WEALTHY_UPPER_BOUND_POSTTEXT
      @result[:icon_emoji] = @coin_config_module::WEALTHY_UPPER_BOUND_EMOJI
    elsif balance > 0 && balance < @coin_config_module::WEALTHY_UPPER_BOUND
      @result[:text] += @coin_config_module::BALANCE_REPLY_POSTTEXT
    end
  end
        def chart
 @result[:attachments] = [{
      title: "Reddcoin Price Chart BTC/RDD",
      title_link: "https://bittrex.com/market/MarketStandardChart?marketName=BTC-RDD",
      color: "#0092ff",
      footer: "https://bittrex.com/",
      footer_icon: "https://bittrex.com/Content/img/logos/bittrex-16.png",
      attachment_type: "default",
}]
end

   def deposit
         @result[:text] = "@#{@user_name} #{@coin_config_module::DEPOSIT_PRETEXT} #{user_address(@user_id)} #{@coin_config_module::DEPOSIT_POSTTEXT} :reddbank:"
        end

 def tip
    user = @params.shift
    raise @coin_config_module::TIP_ERROR_TEXT unless user =~ /<@(U.+)>/

    target_user = $1
    set_amount
    tx = client.sendfrom @user_id, user_address(target_user), @amount

    @result[:text] = "#{@coin_config_module::TIP_PRETEXT} <@#{@user_id}> -> <@#{target_user}> #{@amount}#{@coin_config_module::CURRENCY_ICON}"
    @result[:attachments] = [{
      fallback:"<@#{@user_id}> -> <@#{target_user}> #{@amount}RDD :reddcoin:",
      color: "#ED1B24",
      fields: [{
        title: "Tipping initiated of #{@amount} RDD :reddcoin:",
        value: "http://live.reddcoin.com/tx/#{tx}",
        short: false
      },{
        title: "Tipper",
        value: "<@#{@user_id}>",
        short: true
     },{
        title: "Recipient",
        value: "<@#{target_user}>",
        short: true
        }]
    }]
  end

  alias :":reddcoin:" :tip


  def withdraw
    address = @params.shift
    set_amount
    tx = client.sendfrom @user_id, address, @amount
    @result[:text] = "@#{@user_name} #{@coin_config_module::WITHDRAW_TEXT} <@#{@user_id}> -> #{address} #{@amount}#{@coin_config_module::CURRENCY_ICON} "
    @result[:text] += " (<#{@coin_config_module::TIP_POSTTEXT1}#{tx}#{@coin_config_module::TIP_POSTTEXT2}>)"
    @result[:icon_emoji] = @coin_config_module::WITHDRAW_ICON
  end

 private

  def set_amount
    amount = @params.shift
    @amount = amount.to_f
    randomize_amount if (@amount == "random")

    raise @coin_config_module::TOO_POOR_TEXT + @coin_config_module::FEE unless available_balance >= @amount + 1
    raise @coin_config_module::NO_PURPOSE_LOWER_BOUND_TEXT if @amount < @coin_config_module::NO_PURPOSE_LOWER_BOUND
  end

  def randomize_amount
    lower = [1, @params.shift.to_f].min
    upper = [@params.shift.to_f, available_balance].max
    @amount = rand(lower..upper)
    @result[:icon_emoji] = @coin_config_module::RANDOMIZED_EMOJI
  end

  def available_balance
     client.getbalance(@user_id)
  end

  def user_address(user_id)
     existing = client.getaddressesbyaccount(user_id)
    if (existing.size > 0)
      @address = existing.first
    else
      @address = client.getnewaddress(user_id)
    end
  end

 def price
        @result[:text] = "#{@coin_config_module::PRICE_PRE}  #{@price}"
end


def leaderboard
end



def help

@result[:text] = @coin_config_module::HELP
end

def hi

@result[:text] = " #{@coin_config_module::HI} @#{@user_name} #{@coin_config_module::GREETING}"
end

def about
@result[:text] =  "#{@coin_config_module::ABOUT}: #{@coin_config_module::ABOUT2} "
end
 def commands

    @result[:text] = "#{ACTIONS.join(', ' )}"
  end


end


