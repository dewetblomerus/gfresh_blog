class CreateClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :classifications do |t|
      t.references :tag, foreign_key: true
      t.references :taggable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
