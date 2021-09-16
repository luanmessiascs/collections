class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :poster
      t.text :description

      t.timestamps
    end
  end
end
