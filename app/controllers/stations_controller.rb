#require 'geokit'
class StationsController < ApplicationController

  def index
    @stations = Station.all
    @station = Station.new
  end

  def show
    @station = Station.find(params[:id])
    @geo = Geokit::Geocoders::GoogleGeocoder.geocode("#{@station.street}, #{@station.city}, #{@station.zipcode}")
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(params[:station])
    if @station.save
    if !params[:integrated_view].nil?
    redirect_to stations_integrated_view_path, :notice => "Successfully created station."
    else
    redirect_to stations_url, :notice => "Successfully created station."
    end
    else
    render :new
    end
  end

  def edit
    @station = Station.find(params[:id])
    if !params[:get].nil?
    render :layout=>false
    end
  end

  def update
    @station = Station.find(params[:id])
    if @station.update_attributes(params[:station])
      if !params[:integrated_view].nil?
        redirect_to stations_integrated_view_path, :notice => "Successfully created station."
      else
        redirect_to stations_url, :notice => "Successfully created station."
      end
    else
      render :edit
    end
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    if !params[:integrated_view].nil?

    redirect_to stations_integrated_view_path, :notice => "Successfully destroyed station."
    else
    redirect_to stations_url, :notice => "Successfully destroyed station."
    end
  end

  def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
    book = Spreadsheet.open "#{file.store_path}"
    sheet1 = book.worksheet 0

    @station  = []
    @errors = Hash.new
    @counter = 0

    sheet1.each 1 do |row|
    @counter+=1
    p = Station.new
    p.name = row[0]
    p.description = row[1]
    p.zipcode = row[2]
    p.street = row[3]
    p.city = row[4]

    unless Station.find_by_name_and_description_and_zipcode_and_street_and_city(p.name,p.description,p.zipcode,p.street,p.city)
      if p.valid?
        p.save
      else
        @errors["#{@counter+1}"] = p.errors
      end
    end
    end
    file.remove!
    if @errors.empty?
    redirect_to station, notice: 'All Dummy data were successfully uploaded.'
    else
    redirect_to station, notice: 'There were some errors in your upload'
    end

    else
    redirect_to station, notice: 'Dummy datum could not be successfully uploaded.'
    end
    end
    def integrated_view
    @stations = Station.all
    @station = Station.new
    render :layout=>'scaffold'
  end

end
