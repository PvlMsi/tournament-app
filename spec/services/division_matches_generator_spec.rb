# frozen_string_literal: true

RSpec.describe DivisionMatchesGenerator do
  subject { described_class.new(division).call }

  describe '#call' do
    let(:division) { create(:division) }
    let!(:teams) do
      8.times do |number|
        create(:team, division: division, name: "Team#{number}")
      end
    end

    before { subject }

    it 'creates proper number of division matches' do
      expect(division.matches.map(&:round).uniq).to eq(['division'])
      expect(division.matches.size).to eq(28)
    end
  end
end
