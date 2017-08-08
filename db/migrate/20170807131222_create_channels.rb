class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
      t.string :title, index: { unique: true }, null: false
      t.belongs_to :owner, index: true, null: false

      t.timestamps
    end
  end
end
