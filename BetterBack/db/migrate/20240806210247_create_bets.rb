class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.string :title
      t.string :description
      t.integer :stakes

      t.timestamps
    end
  end
end
