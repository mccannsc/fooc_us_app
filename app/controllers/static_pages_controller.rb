class StaticPagesController < ApplicationController
  caches_page [:home, :about, :contact, :team, :press] 
  
  def home
    if signed_in?
      @user = current_user
      @tasks = @user.tasks.paginate(page: params[:page], per_page: 5)
      @task = current_user.tasks.build
    end
    
  end

  def about
  end

  def contact
  end

  def team
  end

  def press
  end
end
