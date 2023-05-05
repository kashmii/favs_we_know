class AddImagesToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :images, :json
  end
end
