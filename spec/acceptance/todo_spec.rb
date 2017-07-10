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

  route '/todos/:id', 'Get a todo' do
    get 'Get a todo' do
      let(:id) { todo.id }
      let(:todo) { create(:todo) }
      let(:expected_json) { TodoSerializer.new(todo).to_json }

      example_request 'exists' do
        expect(response_body).to eq expected_json
        expect(status).to eq 200
      end
    end

    get 'Get a todo' do
      let(:id) { 0 }
      let(:expected_json) { {id: ['Not found']}.to_json }

      example_request 'not exists' do
        expect(response_body).to eq expected_json
        expect(status).to eq 404
      end
    end
  end
end
