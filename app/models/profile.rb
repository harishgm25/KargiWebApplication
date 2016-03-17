class Profile
  include Mongoid::Document
  include Mongoid::Paperclip

  field :firstname, type: String
  field :lastname, type: String
  field :shopname, type: String
  field :address, type: String
  field :tanvat, type: String
  field :registerno, type: String
  field :shopestablishment, type: String
  field :tradelicense, type: String
  field :manufacturinglicense, type: String

  belongs_to :user,  :dependent => :destroy  
  accepts_nested_attributes_for   :user

   has_mongoid_attached_file :profileImg
   do_not_validate_attachment_file_type :profileImg

  
end
