class ContactsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @contacts = pagy(Contact.where(user_id: current_user.id))
  end
end
