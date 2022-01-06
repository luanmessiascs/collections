class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :poster
      t.text :description
      t.references :collection, null: false, forein_key: true

      t.timestamps
    end
  end
end
