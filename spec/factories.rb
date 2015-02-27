FactoryGirl.define do

  factory :user, class:Hash do
    id "671f5988-5e30-4164-9aed-7f9d46fc6c56"
		password "6aa048e78b0d"

		initialize_with { attributes }
  end

  factory :card, class:Hash do
    name "Testing card"
		number "4111111111111111"
		expiration_month "12"
		expiration_year "2015"

		initialize_with { attributes }
  end

  factory :credit_card, class:Hash do
  	cvv "123"

  	initialize_with { attributes }
  end

  factory :transaction, class:Hash do
		recipient "cc25a077-0b82-4e14-aa2a-6e38cafebebb"
		amount "100"
		order_number 12345
		credit_card

		initialize_with { attributes }
	end

end