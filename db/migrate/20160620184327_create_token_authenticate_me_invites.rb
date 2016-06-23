class CreateTokenAuthenticateMeInvites < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table(:token_authenticate_me_invites, id: :uuid) do |t|
      t.string :email, null: false
      t.boolean :accepted, default: nil
      t.jsonb :meta, null: false, default: '{}'
      t.integer :creator_id, index: true

      t.timestamps null: false
    end
  end
end
