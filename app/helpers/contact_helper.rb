module ContactHelper
  include Pagy::Frontend

  def safe_fields
    ['Name', 'Date of Birth', 'Phone', 'Address', 'Last credit card numbers', 'Franchise', 'E-mail']
  end

  def safe_attributes
    %i[name date_of_birth phone address last_credit_card_numbers franchise email]
  end
end
