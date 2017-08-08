class CreateNicks < ActiveRecord::Migration[5.1]
  def change
    create_table :nicks do |t|
      t.string :name, index: { unique: true }
      t.string :token_digest
      t.string :status

      t.timestamps
    end
  end
end
