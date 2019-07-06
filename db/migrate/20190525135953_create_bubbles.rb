class CreateBubbles < ActiveRecord::Migration[5.1]
  def change
    create_table :bubbles do |t|

      t.timestamps
    end
  end
end
