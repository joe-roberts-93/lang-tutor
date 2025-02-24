class AddFeedbackToSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_column :submissions, :feedback, :text
  end
end
