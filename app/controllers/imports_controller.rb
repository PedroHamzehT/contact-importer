class ImportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(user_id: current_user.id, file: import_params[:file])

    if @import.save
      # ImportContactsWorker.perform_later(@import.id)

      redirect_to '/imports', notice: 'Your contacts will be imported'
    else
      render :new
    end
  end

  private

  def import_params
    params.require(:import).permit(:file, headers: {})
  end
end
