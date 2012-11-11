class ChargesController < ApplicationController

  before_filter :load_station

  def load_station
    @station = Station.find(params[:station_id])
  end

  def index
    @charges = Charge.all
  end

  def show
    @charge = @station.charges.find(params[:id])
  end

  def new
    
    unless params[:us].blank?
      @charge = @station.charges.build(:device => request.env['HTTP_USER_AGENT'], :power => 3.00)
      @charge.save
    end

  end

  def parse_save_from_excel
    test_file = params[:excel_file]
    file = FileUploader.new
    if file.store!(test_file)
      book = Spreadsheet.open "#{file.store_path}"
      sheet1 = book.worksheet 0

       @charge  = []
      @errors = Hash.new
      @counter = 0

      sheet1.each 1 do |row|
        @counter+=1
        p = Charge.new
         p.device = row[0]
         p.power = row[1]
         p.station_id = row[2]

         p.user_id = row[3]
        unless Charge.find_by_device_and_power_and_station_id_and_user_id(p.device,p.power,p.station_id,p.user_id)
          if p.valid?
            p.save
          else
            @errors["#{@counter+1}"] = p.errors
          end
        end
      end
      file.remove!
      if @errors.empty?
        redirect_to charge, notice: 'All Dummy data were successfully uploaded.'
      else
        redirect_to charge, notice: 'There were some errors in your upload'
      end

    else
      redirect_to charge, notice: 'Dummy datum could not be successfully uploaded.'
    end
  end

  def integrated_view
    @charges = Charge.all 
    @charge = Charge.new
    render :layout=>'scaffold'
  end
end
