# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stat, type: :model do
  subject {  FactoryBot.create :stat, :with_pokemon }

  it { should belong_to(:pokemon) }
  it { should be_valid }
end
