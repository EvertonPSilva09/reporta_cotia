class AddStatusToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :status, :integer
  end
end
