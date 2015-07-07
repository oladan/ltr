class Point < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.references :user, null: false
      t.string :title, null: false, default: ''

      t.timestamps
    end
  end

  def self.down
    drop_table(:points)
  end

end
