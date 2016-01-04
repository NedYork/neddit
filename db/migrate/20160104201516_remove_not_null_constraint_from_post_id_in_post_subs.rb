class RemoveNotNullConstraintFromPostIdInPostSubs < ActiveRecord::Migration
  def change
    change_column_null :post_subs, :post_id, true
    change_column_null :post_subs, :sub_id, true 
  end
end
