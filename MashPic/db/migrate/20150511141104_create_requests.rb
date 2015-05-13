class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :keyword1
      t.string :keyword2
      t.string :keyword3
    end
  end
end
