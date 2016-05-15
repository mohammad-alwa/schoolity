require 'rails_helper'

RSpec.describe StudentPolicy do
  let(:school) { build(:active_school, owner: owner) }
  let(:student) { build(:student, school: school) }
  let(:admin) { build(:admin) }
  let(:owner) { build(:user) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:user) { build(:user) }
  let(:other_school) { build(:active_school) }
  let(:other_student) { build(:student) }

  subject { described_class }

  permissions :index? do
    it 'allows admin' do
      expect(subject).to permit(admin, school)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, school)
    end

    it 'prevents school owner from accessing students in other schools' do
      expect(subject).not_to permit(owner, other_school)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, school)
    end

    it 'prevents school admin form accessing students in other schools' do
      expect(subject).not_to permit(school_admin, other_school)
    end

    it 'allows teacher' do
      pending
      expect(subject).to permit(teacher, school)
    end

    it 'prevents teacher from accessing students not in his classrooms' do
      pending
      expect(subject).to permit(teacher, other_school)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, school)
    end

  end

  permissions :show? do
    it 'allows admin' do
      expect(subject).to permit(admin, student)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, student)
    end

    it 'prevents school owner from accessing students in other schools' do
      expect(subject).not_to permit(owner, other_student)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, student)
    end

    it 'prevents school admin form accessing students in other schools' do
      expect(subject).not_to permit(school_admin, other_student)
    end

    it 'allows teacher' do
      pending
      expect(subject).to permit(teacher, student)
    end

    it 'prevents teacher from accessing students not in his classrooms' do
      pending
      expect(subject).not_to permit(teacher, other_student)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, student)
    end
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it 'allows admin' do
      expect(subject).to permit(admin, student)
    end

    it 'allows school owner' do
      expect(subject).to permit(owner, student)
    end

    it 'prevents school owner from accessing students in other schools' do
      expect(subject).not_to permit(owner, other_student)
    end

    it 'allows school admin' do
      expect(subject).to permit(school_admin, student)
    end

    it 'prevents school admin form accessing students in other schools' do
      expect(subject).not_to permit(school_admin, other_student)
    end

    it 'prevents teacher' do
      pending
      expect(subject).not_to permit(teacher, student)
    end

    it 'prevents other users' do
      expect(subject).not_to permit(user, student)
    end
  end
end
