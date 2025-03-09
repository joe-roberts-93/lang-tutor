class AddTitleToSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_column :submissions, :title, :string
  end
end
