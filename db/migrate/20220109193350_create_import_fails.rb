class CreateImportFails < ActiveRecord::Migration[6.1]
  def change
    create_table :import_fails do |t|
      t.string :line_data
      t.string :fail_reasons
      t.references :import, null: false, foreign_key: true

      t.timestamps
    end
  end
end
