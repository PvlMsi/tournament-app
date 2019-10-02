# frozen_string_literal: true

RSpec.describe DivisionsController, type: :controller do
  subject { post :generate_results, params: { id: division_a.id } }

  describe '#generate_results' do
    let(:tournament) { create(:tournament) }
    let(:division_a) { create(:division, tournament: tournament) }
    let(:division_b) { create(:division, tournament: tournament, name: 'B') }
    let!(:teams) do
      8.times do |number|
        create(:team, division: division_a, name: "Team#{number}")
      end
    end

    it 'creates new matches' do
      expect { subject }.to change { division_a.matches.finished.count }.by(28)
    end

    context 'when one of divisions is already filled' do
      let!(:disivison_b_teams) do
        8.times do |number|
          create(:team, division: division_b, name: "B_Team#{number}")
        end
      end

      before do
        DivisionMatchesGenerator.new(division_b).call
        ResultsGenerator.new(division_b.matches).call

        subject
      end

      it 'generates playoff matches' do
        expect(tournament.playoff.matches.size).to eq(7)
      end
    end
  end
end
