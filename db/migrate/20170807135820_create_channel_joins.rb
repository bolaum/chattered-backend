class CreateChannelJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :channel_joins do |t|
      t.belongs_to :nick, index: true, null: false
      t.belongs_to :channel, index: true, null: false
      t.timestamps
    end
    add_index :channel_joins, [:nick_id, :channel_id], unique: true
  end
end
