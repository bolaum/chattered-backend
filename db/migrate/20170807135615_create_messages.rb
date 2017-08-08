class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.datetime :sent_at, null: false
      t.belongs_to :nick, index: true, null: false
      t.belongs_to :channel, index: true, null: false

      t.timestamps
    end
  end
end
