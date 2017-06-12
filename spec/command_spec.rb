require 'spec_helper'

describe Command do
  let(:params) { 
    { 
      'trigger_word' =>'reddbot', 
      'user_name' => 'Samson', 
      'user_id' => '12345' 
    }
  }

  it "Should parse the balance command" do 
    params['text'] = 'reddbot balance'
    c = Command.new params
    c.action.should eq "balance"
    c.user_name.should eq "Samson"
  end

  it "should know my balance is 0" do
    params['text'] = 'reddbot balance'
    c = Command.new params
    c.perform
    c.result.should eq "Balance for Samson is 0.0"
  end
end
