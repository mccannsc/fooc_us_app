class ChangeAdminStatus < ActiveRecord::Migration
  def up
    User.update(8, :admin => true)
  end

  def down
  end
end
