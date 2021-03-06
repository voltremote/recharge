class Station < ActiveRecord::Base

  set_table_name :stations

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save :set_lat_lng, :if => lambda {|s| self.street_changed? or self.city_changed? or self.zipcode_changed? } 

  # ---------------
  # Accessible Attributes
  # ---------------
  # Only accessible attributes can be created or modified. In case, you add more attributes through a later migration,
  # remember to add the attribute to the attr_accessible list. Otherwise, many an hour is lost in figuring out why data is not
  # getting captured through forms...

  attr_accessible :name, :description, :zipcode, :street, :city

  has_many :charges
  has_many :users, :through => :charges 
  
  def set_lat_lng
    return false if (self.street.blank? or self.city.blank? or self.zipcode.blank?)
    geo = Geokit::Geocoders::GoogleGeocoder.geocode("#{self.street}, #{self.city}, #{self.zipcode}") 
    return false unless geo.success 
    self.lat = geo.lat
    self.lng = geo.lng 
  end

  # ---------------
  # Associations
  # ---------------
  # Uncomment, copy and add you associations here...
  # belongs_to                :parent
  # has_many                  :children, :dependent=>:destroy
  # has_and_belongs_to_many   :friends
  # has_one                  :life


  # ---------------
  # Validations
  # ---------------
  # These are the standard validations that you might need to use with the models. Please uncomment as required...

  
  # validates_presence_of :name
  # validates_length_of :name ,:maximum=>255
    
  # validates_presence_of :description
    
  # validates_presence_of :zipcode
  # validates_length_of :zipcode ,:maximum=>255
    
  # validates_presence_of :street
  # validates_length_of :street ,:maximum=>255
    
  # validates_presence_of :city
  # validates_length_of :city ,:maximum=>255
    
  # ---------------
  # Schema Information
  # ---------------
  # Just so that you do not have to open up the migration file to check this everytime...

    
  # name:string
    
  # description:text
    
  # zipcode:string
    
  # street:string
    
  # city:string
    

  # ---------------
  # Scope
  # ---------------
  # Consider using a model scope if you find yourself having to use 'order' too frequently in your finds

  # default_scope order('created_at DESC')

end
