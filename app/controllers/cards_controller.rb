class CardsController < ApplicationController

  require "payjp"

  def index
    
  end

  def new
    @card = CreditCard.new(user_id: current_user.id)
  end

  def show
    
  end
end
