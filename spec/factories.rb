# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    name { 'World Cup' }
  end

  factory :division do
    name { 'A' }
    tournament
  end

  factory :playoff do
    tournament
  end

  factory :team do
    name { 'TeamA' }
    division
  end

  factory :match do
    first_team { build(:team) }
    second_team { build(:team, name: 'TeamB') }
    winner { nil }
    parent { build(:division) }
    round { 'division' }
  end

  factory :semi_final_match, parent: :match do
    first_team { nil }
    second_team { nil }
    winner { nil }
    parent { build(:playoff) }
    round { 'semi_final' }
  end
end
