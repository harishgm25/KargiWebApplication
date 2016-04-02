class FindconnectionsController < ApplicationController
  before_action :set_findconnection, only: [:show, :edit, :update, :destroy]

  # GET /findconnections
  # GET /findconnections.json
  def index
    @findconnections = Findconnection.all
  end

  # GET /findconnections/1
  # GET /findconnections/1.json
  def show
  end

  # GET /findconnections/new
  def new
    @findconnection = Findconnection.new
  end

  # GET /findconnections/1/edit
  def edit
  end

  # POST /findconnections
  # POST /findconnections.json
  def create
    @findconnection = Findconnection.new(findconnection_params)

    respond_to do |format|
      if @findconnection.save
        format.html { redirect_to @findconnection, notice: 'Findconnection was successfully created.' }
        format.json { render :show, status: :created, location: @findconnection }
      else
        format.html { render :new }
        format.json { render json: @findconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /findconnections/1
  # PATCH/PUT /findconnections/1.json
  def update
    respond_to do |format|
      if @findconnection.update(findconnection_params)
        format.html { redirect_to @findconnection, notice: 'Findconnection was successfully updated.' }
        format.json { render :show, status: :ok, location: @findconnection }
      else
        format.html { render :edit }
        format.json { render json: @findconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /findconnections/1
  # DELETE /findconnections/1.json
  def destroy
    @findconnection.destroy
    respond_to do |format|
      format.html { redirect_to findconnections_url, notice: 'Findconnection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_findconnection
      @findconnection = Findconnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def findconnection_params
      params.require(:findconnection).permit(:friend, :status)
    end
end
