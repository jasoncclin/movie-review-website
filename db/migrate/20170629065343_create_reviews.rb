class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :movie
      t.text :description
      t.timestamps
    end
  end
end
