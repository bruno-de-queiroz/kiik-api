require "spec_helper"

describe Kiik do
  
  
  context 'initialization' do

    before(:each) do
        Kiik.config_path = 'spec/fixtures/kiik.yml'
    end

    it 'should set the token' do
      expect(Kiik.config[:token]).to eq("d93bdf60292bdb7dfab02c47d2a1de75")
    end

    it 'should set the wallet object' do
      expect(Kiik.config[:wallet]).not_to  be_empty
    end

  end

  describe Kiik::Wallet do

    context "initialization" do
      let(:wallet) { Kiik.wallet }

      it 'should set the token' do
        expect(wallet.token).to eq("d93bdf60292bdb7dfab02c47d2a1de75")
      end

      it 'should set the app_id' do
        expect(wallet.id).to eq("JUPA")
      end

      it 'should set the app_secret' do
        expect(wallet.secret).to eq("dIBZhUs2f1+b57L9Bg5wG4LqEj7ZiBWwBo+zBjAW+r0=")
      end

      it 'should use token in header' do
        wallet.use_token('abcde') do |wallet|
            expect(wallet.client.authorization_header({})['Authorization']).to eq('Token token=abcde')
        end
      end

      it 'should use default token' do
        expect(wallet.client.authorization_header({})['Authorization']).to eq('Token token=d93bdf60292bdb7dfab02c47d2a1de75')
      end

    end

  end
  

end
