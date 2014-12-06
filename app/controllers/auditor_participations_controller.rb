class AuditorParticipationsController < ApplicationController
  before_action :set_site

  # POST /sites/1/auditor_participations
  # POST /sites/1/auditor_participations.json
  def create
    @auditor_participation = @site.auditor_participations.build
    @auditor = User.find_by_email(auditor_participation_params[:email])
    @auditor_participation.user = @auditor

    respond_to do |format|
      if @auditor_participation.save
        format.html { redirect_to @site, notice: 'AuditorParticipation was successfully created.' }
        format.json { render :show, status: :created, location: @auditor_participation }
      else
        format.html { redirect_to @site }
        format.json { render json: @auditor_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1/auditor_participations/1
  # DELETE /sites/1/auditor_participations/1.json
  def destroy
    @auditor_participation = @site.auditor_participations.find(params[:id])
    @auditor_participation.destroy
    
    respond_to do |format|
      format.html { redirect_to @site, notice: 'AuditorParticipation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_site
      @site = Site.find(params[:site_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auditor_participation_params
      params.require(:auditor_participation).permit(:email)
    end
end
