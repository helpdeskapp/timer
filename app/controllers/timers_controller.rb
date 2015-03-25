class TimersController < ApplicationController
  inherit_resources

  actions :all, :except => :show
  custom_actions :collection => [:start, :stop, :manual]

  def create
    current_user.stop_all_active_timers

    if params[:timer][:date] || params[:timer][:time]
      @timer = Timer.new(timer_params)

      @timer.manual_timer(params[:timer][:date], params[:timer][:time])

      redirect_to timers_path
    else
      create!
    end
  end

  #TODO fix me
  def start
    start!{
      @timer = Timer.find(params[:timer_id])

      current_user.stop_all_active_timers

      if @timer.start_at >= Time.zone.now.beginning_of_day

        @timer.update_attributes(:active => true, :start_at => Time.zone.now)
      else
        if current_user.timers.where(:title => @timer.title, :kind => @timer.kind).today.any?
          @timer = current_user.timers.where(:title => @timer.title, :kind => @timer.kind).today.first

          @timer.update_attributes(:active => true, :start_at => Time.zone.now)
        else
          @timer = Timer.create!(:title => @timer.title, :kind => @timer.kind, :start_at => Time.zone.now, :user => current_user)
        end
      end

      render :partial => 'timers/list', :locals => { :collection => current_user.timers } and return
    }
  end

  def stop
    stop!{
      @timer = Timer.find(params[:timer_id])

      if @timer
        current_user.stop_all_active_timers

        @timer.update_attributes(:active => false, :amount => @timer.spend_time, :end_at => Time.zone.now)
      end

      render :partial => 'timers/list', :locals => { :collection => current_user.timers } and return
    }
  end

  private

  def permitted_params
    params.permit(:timer => [:title, :kind, :date, :time])
  end

  def timer_params
    params.require(:timer).permit(:title, :kind, :date, :time)
  end

  def collection
    current_user.timers
  end

  alias_method :old_build_resource, :build_resource

  def build_resource
    old_build_resource.tap do |object|
      object.user   = current_user
      object.start_at ||= Time.zone.now
    end
  end
end
