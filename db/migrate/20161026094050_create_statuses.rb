class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :name_fi, null: false
      t.string :appearance, null: false
    end
  end
end
