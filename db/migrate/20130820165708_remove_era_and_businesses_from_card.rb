class RemoveEraAndBusinessesFromCard < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.remove :era_points
      t.remove :business_id
    end
  end
end
