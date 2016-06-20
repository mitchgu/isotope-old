class ChangeLoginTokenTokenColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :login_tokens, :token, :token_digest
  end
end
