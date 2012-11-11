class PagesController < ApplicationController
  def welcome
    @stations = Station.all
    @charges = Charge.all
  end
  
  def about
  end
  
  def contact
  end
end
