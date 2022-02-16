class Admin::ApplicationsController < ApplicationController
    def show
        application = Application.find(params[:id])
        application.check_status
        @application = Application.find(params[:id])
    end
end