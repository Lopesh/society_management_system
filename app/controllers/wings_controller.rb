class WingsController < ApplicationController
  before_action :set_wing, only: %i[ show edit update destroy ]

  def index
    @wings = Wing.all
  end

  def show
  end

  def new
    @wing = Wing.new
  end

  def edit
  end

  def create
    society_id = params[:society_id].presence || current_society.id
    service = TenantSwitchingService.new(society_id)
    service.switch_to_new
    @wing = Wing.new(wing_params)

    respond_to do |format|
      if @wing.save
        redirection_path =  current_user.super_admin? ? society_path(service.society) : @wing
        format.html { redirect_to redirection_path, notice: "Wing was successfully created." }
        format.json { render :show, status: :created, location: @wing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wing.errors, status: :unprocessable_entity }
      end
    end
    service.switch_back
  end

  def update
    respond_to do |format|
      if @wing.update(wing_params)
        format.html { redirect_to @wing, notice: "Wing was successfully updated." }
        format.json { render :show, status: :ok, location: @wing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wing.destroy!

    respond_to do |format|
      format.html { redirect_to wings_path, status: :see_other, notice: "Wing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_wing
      @wing = Wing.find(params.expect(:id))
    end

    def set_society
      if params[:society_id].present?
        
      end
    end

    def wing_params
      params.expect(wing: [ :name ])
    end
end
