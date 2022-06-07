class SlotsController < ApplicationController
  def create
    if current_dj
      current_dj.name = params[:name]
      current_dj.save!
    else
      @current_dj = Dj.create!(name: params[:name])
      session[:dj_id] = @current_dj.id
    end

    event = Event.find(params[:event_id])
    event.add_dj!(current_dj)
    
    redirect_to event_path(event)
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