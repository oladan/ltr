class AddCityAndPostalCodeAndStateAndCountryToPoints < ActiveRecord::Migration
  def change
    add_column :points, :city, :string
    add_column :points, :postal_code, :string
    add_column :points, :state, :string
    add_column :points, :country, :string
  end
end
