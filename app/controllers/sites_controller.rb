class SitesController < ApplicationController
  before_action :set_site, only: [:edit, :update, :destroy, :verify_code]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all.order("created_at DESC")
    @my_sites = current_user.sites
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])
  end

  # GET /sites/new
  def new
    @site = current_user.sites.build
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.sites.build(site_params)
    @site.verification_code = SecureRandom.hex

    respond_to do |format|
      if @site.save
        format.html { redirect_to edit_site_path(@site) }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to edit_site_path(@site) }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify_code
    @validated = SiteValidator.validate(url: @site.url, code: @site.verification_code)
    @site.verify!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = current_user.sites.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:url, :private_description, :public_description, :screenshot)
    end
end
