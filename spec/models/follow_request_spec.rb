require 'rails_helper'

RSpec.describe FollowRequest, type: :model do
  
    describe "Direct Associations" do

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do

    it { should validate_uniqueness_of(:recipient_id).scoped_to(:sender_id).with_message('already requested') }

    it { should validate_presence_of(:recipient_id) }

    it { should validate_presence_of(:sender_id) }
      
    end
end
