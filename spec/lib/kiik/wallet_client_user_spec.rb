require "spec_helper"

describe Kiik do

  before(:each) do
      Kiik.config_path = 'spec/fixtures/kiik.yml'
  end

  describe Kiik::Wallet::Client do

    let(:wallet) { Kiik.wallet }
    let!(:user) { build(:user) }
    let!(:card) { build(:card) }
    let!(:transaction) { build(:transaction, :credit_card => build(:credit_card) ) }

    context "initialization" do

      it 'should set the user api ' do
        expect(wallet.user).not_to be_nil
      end

      it 'should set the user api ' do
        wallet.user.login(user) do |response|
          expect(response['token']).not_to be_nil
        end
      end

      it 'should use the token to create a card' do
        wallet.user.login(user) do |response|

          card[:token] = response['token']

          wallet.create(:creditcard, card) do |response|
            expect(response['credit_card_token']).not_to be_nil
          end
        end
      end

      it 'should use the token to create a card and make a transaction' do

        wallet.user.login(user) do |response|

          token = response['token']

          card[:token] = token

          wallet.create(:creditcard, card) do |response|

            transaction[:token] = token
            transaction[:credit_card][:token] = response['credit_card_token']

            wallet.create(:transaction, transaction ) do |response|
              expect(response).not_to be_nil
            end

          end
        end
      end

    end

  end


end
