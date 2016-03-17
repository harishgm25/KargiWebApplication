class Product
  include Mongoid::Document
  include Mongoid::Paperclip
  field :name, type: String
  field :description, type: String
  field :color, type: String
  field :material, type: String
  field :price, type: Float
  field :discount, type: Integer
  field :quantity, type: Integer
  

  has_mongoid_attached_file :image,:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

def image_url
        image.url(:thumb)
end
end
