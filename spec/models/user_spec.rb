require "rails_helper"

RSpec.describe User, type: :model do
  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
  end

   describe "#phone" do
    it { is_expected.to validate_presence_of(:phone) }
  end

   describe "#password" do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_length_of(:password) }
  end

  describe "associations" do
    it { is_expected.to have_many(:reviews)}
    it { is_expected.to have_many(:comments)}
    it { is_expected.to have_many(:likes)}
    it { is_expected.to have_many(:bookings)}
  end
end
