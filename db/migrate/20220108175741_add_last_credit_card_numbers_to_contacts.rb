class AddLastCreditCardNumbersToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :last_credit_card_numbers, :string, null: false
  end
end
