# frozen_string_literal: true

RSpec.describe PlayoffMatchesGenerator do
  subject { described_class.new(playoff).call }

  describe '#call' do
    let(:tournament) do
      create(
        :tournament,
        divisions: [create(:division), create(:division, name: 'B')]
      )
    end

    let!(:teams) do
      tournament.divisions.each do |division|
        8.times do |number|
          create(:team, division: division, name: "#{division.name}_team#{number}")
        end
      end
    end

    let(:playoff) { create(:playoff, tournament: tournament) }

    before do
      tournament.divisions.each do |division|
        DivisionMatchesGenerator.new(division).call
      end

      subject
    end

    it 'creates proper number of matches' do
      expect(playoff.matches.final.size).to eq(1)
      expect(playoff.matches.semi_final.size).to eq(2)
      expect(playoff.matches.quarter_final.size).to eq(4)
    end
  end
end
