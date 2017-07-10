class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

    def not_found(exception)
      model = build_error_model(exception.model, :id, 'Not found')
      render json: model.errors, status: :not_found
    end

    def build_error_model(model_name, attribute, message)
      model = model_name.classify.constantize.new
      model.errors.add(attribute, message)
      model
    end
end
