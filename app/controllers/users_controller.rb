class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show, :destroy]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :admin_user, only: :index
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to FocusPush. Let's get going."
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.paginate(page: params[:page], per_page: 5, total_entries: 25)
    @task_time =  Task.find_by_user_id(params[:id])
    gon.time = @task_time.time
    @user_id = @user.id
    @task_length = Task.sum(:time, conditions: "user_id = #{@user_id}")
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @number_of_users = User.count
    @number_of_tasks = Task.count
  end
  
  def destroy
    @user = User.find(params[:id])
    @user_id = @user.id
    @task = Task.find_by_user_id(@user_id)
    @task.delete
    flash[:error] = "Fail! You have started to procastinate. Your last task has been deleted."
    redirect_to root_path
  end
  
        private
        
          
          
          def correct_user
            @user = User.find(params[:id])
            redirect_to(root_path) unless current_user?(@user)
          end
          
          def admin_user
            redirect_to(root_path) unless current_user.admin?
          end
  
end
