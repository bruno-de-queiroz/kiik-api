require "spec_helper"

describe Kiik do
  
  before(:each) do
      Kiik.config_path = 'spec/fixtures/kiik.yml'
  end

  describe Kiik::Wallet::Client do
    
    let(:wallet) { Kiik.wallet }
    
    context "initialization" do

      it 'should set the user api ' do
        expect(wallet.user).not_to be_nil
      end

    end

  end
  

end
