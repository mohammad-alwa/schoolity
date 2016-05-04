require 'rails_helper'

RSpec.describe SchoolAdministrationPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:owner) { create(:user) }
  let(:school) { create(:active_school, owner: owner) }
  let(:other_school) { create(:active_school) }
  let(:school_administration) { create(:school_administration, administrated_school: school) }
  let(:other_school_administration) { create(:school_administration, administrated_school: other_school) }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, other_school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end
  end


  permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, school_administration)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school_administration)
    end

    it 'prevents school owner from accessing other schools' do
      expect(subject).not_to permit(owner, other_school_administration)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school_administration)
    end
  end
end
