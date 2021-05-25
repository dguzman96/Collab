module Group::ConversationsHelper

  def contacts_except_recipient(recipient)
    contacts = current_user.all_active_contacts
    # return all contacts, except the opposite user of the chat
    contacts.delete_if {|contact| contact.id == recipient.id }
  end

  def create_group_conv_partial_path(contact)
    if recipient_is_contact?
      'private/conversations/conversation/heading/create_group_conversation'
    else
      'shared/empty_partial'
  end
end
