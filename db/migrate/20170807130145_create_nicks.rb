class CreateNicks < ActiveRecord::Migration[5.1]
  def change
    create_table :nicks do |t|
      t.string :name, index: { unique: true }, null: false
      t.string :token_digest, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
