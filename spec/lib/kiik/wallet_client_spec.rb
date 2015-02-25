require "spec_helper"

describe Kiik do


  context 'initialization' do

    before(:each) do
        Kiik.config_path = 'spec/fixtures/kiik.yml'
    end

    it 'should set the token' do
      expect(Kiik.config[:token]).to eq("098f6bcd4621d373cade4e832627b4f6")
    end

    it 'should set the wallet object' do
      expect(Kiik.config[:wallet]).not_to  be_empty
    end

  end

  describe Kiik::Wallet do

    context "initialization" do
      let(:wallet) { Kiik.wallet }

      it 'should set the token' do
        expect(wallet.token).to eq("098f6bcd4621d373cade4e832627b4f6")
      end

      it 'should set the app_id' do
        expect(wallet.id).to eq("WALT")
      end

      it 'should set the app_secret' do
        expect(wallet.secret).to eq("b5i32od62d5hadxvopcgsdmipv2g8b")
      end

      it 'should use token in header' do
        proc = Proc.new { |wallet| expect(wallet.client.authorization_header({})['Authorization']).to eq('Token token=abcde') }
        wallet.use_token('abcde',&proc)
      end

      it 'should use default token' do
        expect(wallet.client.authorization_header({})['Authorization']).to eq('Token token=098f6bcd4621d373cade4e832627b4f6')
      end



    end

  end


end
