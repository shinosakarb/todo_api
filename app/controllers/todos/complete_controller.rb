class Todos::CompleteController < ApplicationController
  before_action :set_todo, only: :update

  def update
    if @todo.complete
      render nothing: true, status: :ok
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  private

    def set_todo
      @todo = Todo.find(params[:id])
    end
end
