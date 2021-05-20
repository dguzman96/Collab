class CreateGroupConversationsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :group_messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      #t.timestamps
    end
    add_index :group_conversations_users, :conversation_id
    add_index :group_conversations_users, :user_id
  end
end
