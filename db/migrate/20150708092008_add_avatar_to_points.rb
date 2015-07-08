class AddAvatarToPoints < ActiveRecord::Migration
  def self.up
    add_attachment :points, :avatar
  end

  def self.down
    remove_attachment :points, :avatar
  end
end
