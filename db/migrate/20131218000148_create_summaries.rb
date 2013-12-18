class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.references :transaction
      t.references :event

      t.timestamps
    end
    add_index :summaries, :transaction_id
    add_index :summaries, :event_id
  end
end
