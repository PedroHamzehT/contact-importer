class ImportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @imports = Import.where(status: 4)
  end

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(user_id: current_user.id, file: import_params[:file])

    if @import.save
      ImportContactsJob.perform_later(@import.id, import_params[:headers])

      redirect_to '/imports', notice: 'Your contacts will be imported'
    else
      flash[:alert] = 'Contacts cannot be imported'
      render :new
    end
  end

  private

  def import_params
    params.require(:import).permit(:file, headers: {})
  end
end
