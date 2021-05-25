require 'rails_helper'

RSpec.describe Shared::ConversationsHelper, :type => :helper do

  context '#private_conv_seen_status' do
    it 'returns an empty string' do
      current_user = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
              conversation_id: conversation.id,
              seen: false,
              user_id: current_user.id)
      view.stub(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq ''
    end

    it 'returns an empty string' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
              conversation_id: conversation.id,
              seen: true,
              user_id: recipient.id)
      view.stub(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq ''
    end

    it 'returns unseen-conv status' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
              conversation_id: conversation.id,
              seen: false,
              user_id: recipient.id)
      view.stub(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq(
        'unseen-conv'
      )
    end
  end

  context '#contacts_except_recipient' do
    it 'return all contacts, except the opposite user of the chat' do
      contacts = create_list(:contact,
                            5,
                            user_id: current_user.id,
                            accepted: true)

      contacts << create(:contact,
                        user_id: current_user.id,
                        contact_id: recipient.id,
                        accepted: true)
      helper.stub(:current_user).and_return(current_user)
      expect(helper.contacts_except_recipient(recipient)).not_to include recipient
    end
  end

  context '#create_group_conv_partial_path' do
    let(:contact) { create(:contact) }

    it "returns a create_group_conversation partial's path" do
      helper.stub(:recipient_is_contact?).and_return(true)
      expect(helper.create_group_conv_partial_path(contact)).to(
        eq 'private/conversations/conversation/heading/create_group_conversation'
      )
    end

    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      expect(helper.create_group_conv_partial_path(contact)).to(
        eq 'shared/empty_partial'
      )
    end
  end

  context '#group_conv_seen_status' do
    it 'returns unseen-conv status' do
      conversation = create(:group_conversation)
      create(:group_message, conversation_id: conversation.id)
      current_user = create(:user)
      view.stub(:current_user).and_return(current_user)
      expect(helper.group_conv_seen_status(conversation)).to eq(
        'unseen-conv'
      )
    end

    it 'returns an empty string' do
      user = create(:user)
      conversation = create(:group_conversation)
      create(:group_message, conversation_id: conversation.id, user_id: user.id)
      view.stub(:current_user).and_return(user)
      expect(helper.group_conv_seen_status(conversation)).to eq ''
    end

    it 'returns an empty string' do
      user = create(:user)
      conversation = create(:group_conversation)
      message = build(:group_message, conversation_id: conversation.id)
      message.seen_by << user.id
      message.save
      view.stub(:current_user).and_return(user)
      expect(helper.group_conv_seen_status(conversation)).to eq ''
    end
  end
end
