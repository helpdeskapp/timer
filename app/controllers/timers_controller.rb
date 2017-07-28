class TimersController < ApplicationController
  inherit_resources
  load_and_authorize_resource

  actions :all, :except => :show
  custom_actions :collection => [:start, :stop, :manual]

  before_filter :stop_all_active_timers, :only => [:create, :start, :stop]

  def create
    if params[:timer][:date] || params[:timer][:time]
      @timer = current_user.timers.new(timer_params)

      @timer.manual_timer(params[:timer][:date], params[:timer][:time])

      redirect_to timers_path
    else
      create!
    end
  end

  def start
    start!{
      @timer = Timer.find(params[:timer_id])

      @timer.start!

      render :partial => 'timers/list', :locals => { :collection => @collection } and return
    }
  end

  def stop
    stop!{
      @timer = Timer.find(params[:timer_id])

      @timer.stop!

      render :partial => 'timers/list', :locals => { :collection => @collection } and return
    }
  end

  private

  def stop_all_active_timers
    current_user.stop_all_active_timers
  end

  def collection
    @presenter = TimerPresenter.new(params.merge!(:current_user => current_user))

    @collection ||= Kaminari.paginate_array(@presenter.collection).page(params[:page])
  end

  def permitted_params
    params.permit(:timer => [:title, :kind, :date, :time])
  end

  def timer_params
    params.require(:timer).permit(:title, :kind, :date, :time)
  end

  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |object|
      object.user   = current_user
      object.start_at ||= Time.zone.now
    end
  end
end
