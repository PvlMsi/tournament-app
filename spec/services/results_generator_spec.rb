# frozen_string_literal: true

RSpec.describe ResultsGenerator do
  describe '#call' do
    subject { described_class.new(matches).call }

    let(:matches) do
      4.times.map { create(:match) }
    end

    before { subject }

    it 'determines winner of all matches' do
      expect(matches.select(&:present?).size).to eq(4)
    end

    context 'when match has sub match' do
      let(:playoff) { create(:playoff) }
      let(:parent_match) { create(:match, round: 'quarter_final', parent: playoff, sub_match: sub_match) }
      let(:sub_match) { create(:semi_final_match, parent: playoff) }

      before { described_class.new([parent_match]).call }

      it 'fills sub match competitor after parent match determines winner' do
        expect(sub_match.first_team).to eq(parent_match.winner)
      end
    end
  end
end
