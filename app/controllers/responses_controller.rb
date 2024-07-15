class ResponsesController < ApplicationController
    def new
        @response = Response.new
    end

    def create
        @response = Response.new(response_params)
    end

    private
    def response_params
        params.require(:response).permit(:id, :type, :input, :response)
    end
end
