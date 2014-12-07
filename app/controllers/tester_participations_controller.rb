class TesterParticipationsController < ApplicationController
  before_action :set_site

  # POST /sites/1/tester_participations
  # POST /sites/1/tester_participations.json
  def create
    @tester_participation = @site.tester_participations.build
    @tester_participation.user = current_user

    respond_to do |format|
      if @tester_participation.save
        track_activity @tester_participation

        format.html { redirect_to sites_path, notice: 'Te has suscrito correctamnete' }
        format.json { render :show, status: :created, location: @tester_participation }
      else
        format.html { redirect_to @site }
        format.json { render json: @tester_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1/tester_participations/1
  # DELETE /sites/1/tester_participations/1.json
  def destroy
    @tester_participation = @site.tester_participations.find(params[:id])
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
    def tester_participation_params
      params.require(:participation).permit(nil)
    end
end
