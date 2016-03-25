class AddAttachmentProfileimgToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :profileImg
    end
  end

  def self.down
    remove_attachment :profiles, :profileImg
  end
end
