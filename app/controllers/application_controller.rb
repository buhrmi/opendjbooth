class ApplicationController < ActionController::Base
    # This will make validation errors available in form helpers
  # See https://inertiajs.com/forms#form-helper
  rescue_from ActiveRecord::RecordInvalid do |exception|
    raise exception unless request.inertia?
    session[:errors] = exception.record.errors
    redirect_back(fallback_location: '/')
  end

  rescue_from ActionController::BadRequest do |exception|
    flash[:error] = exception.message
    redirect_back(fallback_location: '/')
  end

  inertia_share do
    {
      current_dj: current_dj.try(:as_json),
      errors: session.delete(:errors),
      flash: flash.to_h
    }
  end

  def current_dj
    @current_dj ||= Dj.find_by(id: session[:dj_id]) if session[:dj_id]
  end
end
