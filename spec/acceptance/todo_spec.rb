require 'acceptance_helper'

resource 'Todos' do
  shared_examples 'not found' do
    let(:id) { 0 }
    let(:expected_json) { {id: ['Not found']}.to_json }

    example_request 'not exists' do
      expect(response_body).to eq expected_json
      expect(status).to eq 404
    end
  end

  route '/todos', 'Todos collection' do
    get 'Get todos list' do
      context 'exists' do
        let(:expected_json) { ActiveModel::SerializableResource.new(Todo.all).to_json }

        before { create_list(:todo, 3) }

        example_request 'exists' do
          expect(response_body).to eq expected_json
          expect(status).to eq 200
        end
      end

      context 'not exists' do
        let(:expected_json) { [].to_json }

        example_request 'not exists' do
          expect(response_body).to eq expected_json
          expect(status).to eq 200
        end
      end
    end

    post 'Add a todo' do
      parameter :title, scope: :todo

      context 'success' do
        let(:title) { 'todo1' }

        example_request 'success' do
          expect(status).to eq 201
        end
      end

      context 'failed' do
        let(:title) { '' }

        example_request 'failed' do
          expect(status).to eq 422
        end
      end
    end
  end

  route '/todos/:id', 'Specific todo' do
    get 'Get a todo' do
      context 'exists' do
        let(:id) { todo.id }
        let(:todo) { create(:todo) }
        let(:expected_json) { TodoSerializer.new(todo).to_json }

        example_request 'exists' do
          expect(response_body).to eq expected_json
          expect(status).to eq 200
        end
      end

      context 'not exists' do
        include_examples 'not found'
      end
    end

    patch 'Update a todo' do
      parameter :title, scope: :todo

      let(:todo) { create(:todo) }

      context 'success' do
        let(:title) { 'todo' }
        let(:id) { todo.id }

        example_request 'success' do
          expect(status).to eq 200
        end
      end

      context 'failed' do
        let(:title) { '' }
        let(:id) { todo.id }

        example_request 'failed' do
          expect(status).to eq 422
        end
      end

      context 'not exists' do
        include_examples 'not found'
      end
    end

    delete 'Delete a todo' do
      let(:todo) { create(:todo) }

      context 'success' do
        let(:id) { todo.id }

        example_request 'success' do
          expect(status).to eq 204
        end
      end

      context 'not exists' do
        include_examples 'not found'
      end
    end
  end
end
