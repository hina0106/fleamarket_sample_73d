class RemoveAncestryToBrands < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :ancestry, :string
  end
end
