class Findconnection
  include Mongoid::Document
  field :friend, type: String
  field :status, type: String

  belongs_to :user,  :dependent => :destroy  
  accepts_nested_attributes_for   :user
end
