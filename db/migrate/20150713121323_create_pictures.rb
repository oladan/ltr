class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :title
      t.references :point, index: true

      t.timestamps
    end
  end
end
