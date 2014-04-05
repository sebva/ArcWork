class RemoveFilePathFromHomework < ActiveRecord::Migration
  def change
    remove_column :homeworks, :file, :string
    add_attachment :homeworks, :file
  end
end
