class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  before_filter :authenticate_user!

  layout 'public'

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  private

  def after_sign_in_path_for(resource)
    timers_path
  end
end
