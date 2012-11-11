class Charge < ActiveRecord::Base

   set_table_name :charges

  # ---------------
  # Accessible Attributes
  # ---------------
  # Only accessible attributes can be created or modified. In case, you add more attributes through a later migration,
  # remember to add the attribute to the attr_accessible list. Otherwise, many an hour is lost in figuring out why data is not
  # getting captured through forms...

  attr_accessible :device, :power, :station_id, :user_id

  belongs_to :station
  belongs_to :user

  # ---------------
  # Associations
  # ---------------
  # Uncomment, copy and add you associations here...
  # belongs_to                :parent
  # has_many                  :children, :dependent=>:destroy
  # has_and_belongs_to_many   :charges
  # has_one                  :life


  # ---------------
  # Validations
  # ---------------
  # These are the standard validations that you might need to use with the models. Please uncomment as required...

  
  # validates_presence_of :device
  # validates_length_of :device ,:maximum=>255
    
  # validates_presence_of :power
    
  # validates_presence_of :station_id
  # validates_numericality_of :station_id
    
  # validates_presence_of :user_id
  # validates_numericality_of :user_id
    
  # ---------------
  # Schema Information
  # ---------------
  # Just so that you do not have to open up the migration file to check this everytime...

    
  # device:string
    
  # power:float
    
  # station_id:integer
    
  # user_id:integer
    

  # ---------------
  # Scope
  # ---------------
  # Consider using a model scope if you find yourself having to use 'order' too frequently in your finds

  # default_scope order('created_at DESC')

end
