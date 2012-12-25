class TasksController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = current_user
    @task = current_user.tasks.build(params[:task])
    if @task.save
      flash[:success] = "Task created. Get going!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Check your time is a number and you have completed the task."
      redirect_to root_path     
     # render 'static_pages/home'
    end

  end

  def destroy
  end
end