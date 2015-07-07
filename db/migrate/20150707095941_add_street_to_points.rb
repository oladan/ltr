class AddStreetToPoints < ActiveRecord::Migration
  def change
    add_column :points, :street, :string
  end
end
