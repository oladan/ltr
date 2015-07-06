class ChangePriceInPoints < ActiveRecord::Migration
  def self.up
   change_column :points, :price, :decimal, :precision => 10, :scale => 2
  end
end
