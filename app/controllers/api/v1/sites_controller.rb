class Api::V1::SitesController < ApplicationController

  def create
    _upsert
  end

  def update
    _upsert
  end

  def index
    render json: Site.all
  end

  private

  def _upsert
    site, errors = ::V1::Sites::UpsertSite.new(site_params).exec
    render json: { 
                  errors: Array(errors),
                  data: site,
                  status: site ? 200 : 500
                 }
  end

  def site_params
    params.require(:site).permit(:site_key, :name, regions: {})
  end

end
