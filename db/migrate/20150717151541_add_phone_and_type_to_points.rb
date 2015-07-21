class AddPhoneAndTypeToPoints < ActiveRecord::Migration
  def change
    add_column :points, :phone, :string
    add_reference :points, :type, index: true
  end
end
