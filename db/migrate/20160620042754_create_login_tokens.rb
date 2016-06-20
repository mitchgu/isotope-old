class CreateLoginTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :login_tokens do |t|
      t.belongs_to :user, index: true
      t.string :series
      t.string :token

      t.timestamps
    end
  end
end
