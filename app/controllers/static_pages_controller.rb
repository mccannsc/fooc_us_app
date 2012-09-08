class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
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
