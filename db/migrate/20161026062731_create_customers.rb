class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.belongs_to :unit, null: false
      t.belongs_to :person, null: false
      t.belongs_to :status, null: false, default: 0
      t.belongs_to :referrer
      t.string :referrer_info

      t.timestamps
    end
  end
end
