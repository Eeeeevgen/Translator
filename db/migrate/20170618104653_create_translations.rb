class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.references :user, index: true

      t.string :input_lang, null: false
      t.string :output_lang, null: false
      t.text :input, null: false
      t.text :output, null: false

      t.timestamps
    end
    add_foreign_key :translations, :users
    # add_index :translations, :user_id
  end
end
