class AddPicToPictures < ActiveRecord::Migration
  def self.up
    add_attachment :pictures, :pic
  end

  def self.down
    remove_attachment :pictures, :pic
  end
end
