class RenameLineDataToLineContent < ActiveRecord::Migration[6.1]
  def change
    rename_column :import_fails, :line_data, :line_content
  end
end
