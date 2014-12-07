class VulnerabilitiesController < ApplicationController
  before_action :set_site
  before_action :set_vulnerability, only: [:show, :edit, :update, :destroy]

  # GET /sites/1/vulnerabilities
  # GET /sites/1/vulnerabilities.json
  def index
    @vulnerabilities = @site.vulnerabilities.all
  end

  # GET /sites/1/vulnerabilities/1
  # GET /sites/1/vulnerabilities/1.json
  def show
  end

  # GET /sites/1/vulnerabilities/new
  def new
    @vulnerability = @site.vulnerabilities.build
  end

  # GET /sites/1/vulnerabilities/1/edit
  def edit
  end

  # POST /vulnerabilities
  # POST /vulnerabilities.json
  def create
    unless current_user.testing_sites.include? @site
      raise Exception.new 'No puedes reportar una vulnerabilidad si no estás suscrito a este sitio'
    end

    @vulnerability = @site.vulnerabilities.build(vulnerability_params)
    @vulnerability.user = current_user

    respond_to do |format|
      if @vulnerability.save
        format.html { redirect_to @site, notice: 'Vulnerability was successfully created.' }
        format.json { render :show, status: :created, location: @vulnerability }
      else
        format.html { render :new }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vulnerabilities/1
  # PATCH/PUT /vulnerabilities/1.json
  def update
    respond_to do |format|
      if @vulnerability.update(vulnerability_params)
        format.html { redirect_to @site, notice: 'Vulnerability was successfully updated.' }
        format.json { render :show, status: :ok, location: @vulnerability }
      else
        format.html { render :edit }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @vulnerability.approve!
    track_activity @vulnerability
    redirect_to vulnerability.site
  end

  def reject
    @vulnerability.reject!
    track_activity @vulnerability
    redirect_to vulnerability.site
  end

  def publish
    @vulnerability.publish!
    track_activity @vulnerability
    redirect_to vulnerability.site
  end

  # DELETE /vulnerabilities/1
  # DELETE /vulnerabilities/1.json
  def destroy
    @vulnerability.destroy
    respond_to do |format|
      format.html { redirect_to @site, notice: 'Vulnerability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_site
      @site = Site.find(params[:site_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_vulnerability
      @vulnerability = Vulnerability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vulnerability_params
      params.require(:vulnerability).permit(:title, :description, :attachment)
    end
end
