class CreateJoinTableCustomerUser < ActiveRecord::Migration[5.0]
  def up
    create_join_table :customers, :users do |t|
      t.index [:customer_id, :user_id]
    end

    Customer.find_each(batch_size: 50) do |customer|
      customer.contact_ids = [customer.contact_id]
    end
  end

  def down
    drop_join_table :customers, :users
  end
end
