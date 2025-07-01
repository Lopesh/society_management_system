class SocietiesController < ApplicationController
  before_action :set_society, only: %i[ show edit update destroy ]

  def index
    switch_tenant
    @societies = Society.all
  end

  def show
    service = TenantSwitchingService.new(@society.id)
    service.switch_to_new
    @wings = Wing.all
  end

  def new
    @society = SocietyForm.new
  end

  def edit
  end

  def create
    @society = SocietyForm.new(society_params)
    respond_to do |format|
      if @society.submit
        format.html { redirect_to @society, notice: "Society was successfully created." }
        format.json { render :show, status: :created, location: @society }
      else
        
        format.html do
          @society = SocietyForm.new(society_params)
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @society.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /societies/1 or /societies/1.json
  def update
    respond_to do |format|
      if @society.update(society_params)
        format.html { redirect_to @society, notice: "Society was successfully updated." }
        format.json { render :show, status: :ok, location: @society }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @society.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /societies/1 or /societies/1.json
  def destroy
    @society.destroy!

    respond_to do |format|
      format.html { redirect_to societies_path, status: :see_other, notice: "Society was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_society
      @society = Society.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def society_params
      params.expect(society: [ :name, :address, :subdomain, :contact_email, :phone ])
    end
end
