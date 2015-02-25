module Kiik
    class Wallet
        class Transaction

            def initialize(client)
                @client = client
                @base_uri = '/transactions/card'
            end

            def create(token,card,options={},&block)
                params = {
                    :card => {
                        :credit_card_token => card[:token],
                        :cvv => card[:cvv]
                    },
                    :transaction => {
                        :recipient => options[:recipient],
                        :amount => options[:amount],
                        :order_number => options[:order_number]
                    }
                }

                request(token,:post,@base_uri,params,&block)
            end

            def callback(token,params={},&block)
                request(token,:put,'/payment/callback',params,&block)
            end

            private
                def request(token,verb,url,params,&block)
                    proc = Proc.new { |client| client.request(verb,url,params,&block) }
                    @client.use_token(token, &proc)
                end

        end
    end
end