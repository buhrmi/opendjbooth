class SlotsController < ApplicationController
  def create
    unless @current_dj
      @current_dj = Dj.create!(name: params[:name])
      session[:dj_id] = @current_dj.id
    end

    slot = Slot.create!(slot_params.merge(dj_id: @current_dj.id))
    slot.save!
    redirect_to event_path(slot.event)
  end


  def destroy
    slot = current_dj.slots.find(params[:id])
    slot.destroy
    redirect_to event_path(slot.event)
  end

  private
  def slot_params
    params.require(:slot).permit(:event_id)
  end

end