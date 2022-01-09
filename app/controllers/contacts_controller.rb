class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.where(user_id: current_user.id)
  end
end
