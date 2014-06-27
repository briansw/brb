class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :slideshow_block_id
      t.string :slide_type
      t.text :caption
      t.integer :position
      t.text :video_id
      t.text :video_url

      t.timestamps
    end
  end
end