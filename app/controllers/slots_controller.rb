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
    meters = distance([params[:coords][:lat].to_f, params[:coords][:lng].to_f], [event.latitude, event.longitude])
    
    if meters > 50
      # throw error if more than 50 meters away from booth
    end
    
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

  def distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters
  
    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
  
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
  
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  
    rm * c # Delta in meters
  end

end