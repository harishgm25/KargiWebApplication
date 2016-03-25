  class Profile
  include Mongoid::Document
  include Mongoid::Paperclip

  field :firstname, type: String
  field :lastname, type: String
  field :nameoffirm, type: String
  field :estyear, type: String
  field :website, type: String
  field :pan, type: String
  field :tanvat, type: String
  field :bankacc, type: String
  field :billingaddress, type: String
  field :deliveryaddress, type: String

  belongs_to :user,  :dependent => :destroy  
  accepts_nested_attributes_for   :user

   has_mongoid_attached_file :profileImg,:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
   do_not_validate_attachment_file_type :profileImg
  
end
