class TesterParticipationsController < ApplicationController
  before_action :set_site

  # POST /sites/1/auditor_participations
  # POST /sites/1/auditor_participations.json
  def create
    @tester_participation = @site.auditor_participations.build
    @tester_participation.user = current_user

    respond_to do |format|
      if @tester_participation.save
        format.html { redirect_to @site, notice: 'TesterParticipation was successfully created.' }
        format.json { render :show, status: :created, location: @tester_participation }
      else
        format.html { redirect_to @site }
        format.json { render json: @tester_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1/auditor_participations/1
  # DELETE /sites/1/auditor_participations/1.json
  def destroy
    @tester_participation = @site.auditor_participations.find(params[:id])
    @tester_participation.destroy
    
    respond_to do |format|
      format.html { redirect_to @site, notice: 'TesterParticipation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_site
      @site = Site.find(params[:site_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auditor_participation_params
      params.require(:participation).permit(nil)
    end
end
