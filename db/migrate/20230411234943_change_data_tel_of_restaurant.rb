class ChangeDataTelOfRestaurant < ActiveRecord::Migration[6.0]
  def change
    change_column :restaurants, :tel, :string
  end
end
