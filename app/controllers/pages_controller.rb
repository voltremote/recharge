class PagesController < ApplicationController
  def welcome
    @stations = Station.all
    @charges = Charge.all
  end
  
  def about
    @stations = Station.all
  end
  
  def contact
    @stations = Station.all
  end

end
