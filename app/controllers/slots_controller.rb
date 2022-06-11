class SlotsController < ApplicationController
  def create
    booth = Booth.find(params[:booth_id])
    meters = distance([params[:coords][:lat].to_f, params[:coords][:lng].to_f], [booth.latitude, booth.longitude])
    
    if meters > 1500
      flash[:error] = "You are too far away from the booth. You are #{meters.round} meters away."
      return redirect_back(fallback_location: booth_path(booth, date: slot.start_at.strftime('%Y-%m-%d')))
    end

    if current_dj
      current_dj.name = params[:name]
      current_dj.save!
    else
      @current_dj = Dj.create!(name: params[:name])
      session[:dj_id] = @current_dj.id
    end
    
    preferred_time = Time.parse("#{params[:date]} #{params[:time]}")

    slot = booth.add_dj!(current_dj, preferred_time)
    
    redirect_back(fallback_location: booth_path(booth, date: slot.start_at.strftime('%Y-%m-%d')))
  end


  def destroy
    slot = current_dj.slots.find(params[:id])
    slot.destroy
    redirect_back(fallback_location: booth_path(slot.booth, date: slot.start_at.strftime('%Y-%m-%d')))
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
