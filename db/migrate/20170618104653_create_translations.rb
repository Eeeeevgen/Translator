class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.references :user, index: true

      t.string :input_lang
      t.string :output_lang
      t.text :input
      t.text :output

      t.timestamps
    end
    add_foreign_key :translations, :users
    # add_index :translations, :user_id
  end
end
