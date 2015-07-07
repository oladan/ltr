class AddPriceAndPlaceToPoints < ActiveRecord::Migration
  def change
    add_column :points, :price, :decimal
    add_column :points, :place, :string
  end
end
