require 'acceptance_helper'

resource 'Todos' do
  route '/todos', 'Get todos list' do
    get 'Get todos list' do
      let(:expected_json) { ActiveModel::SerializableResource.new(Todo.all).to_json }

      before { create_list(:todo, 3) }

      example_request 'exists' do
        expect(response_body).to eq expected_json
        expect(status).to eq 200
      end
    end

    get 'Get todos list' do
      let(:expected_json) { [].to_json }

      example_request 'not exists' do
        expect(response_body).to eq expected_json
        expect(status).to eq 200
      end
    end
  end
end
