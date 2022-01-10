class ImportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @on_hold_imports = Import.includes(:file_attachment).where(status: 0, user_id: current_user.id)
    @processing_imports = Import.includes(:file_attachment).where(status: 1, user_id: current_user.id)
    @finished_imports = Import.includes(:file_attachment).where(status: 3, user_id: current_user.id)
    @failed_imports = Import.includes(:file_attachment).where(status: 2, user_id: current_user.id)
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

  def fails
    @import = Import.includes(:file_attachment).find(params[:id])

    @import_fails = @import.import_fails
  end

  private

  def import_params
    params.require(:import).permit(:file, headers: {})
  end
end
