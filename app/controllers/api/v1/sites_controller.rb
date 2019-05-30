class Api::V1::SitesController < ApplicationController
  before_action :load_sites, only: [:index]
  
  def create
    _upsert
  end

  def update
    _upsert
  end

  def index
    render json: ::V1::SiteSerializer.new(Site.all).serializable_hash
  end

  private

  def _upsert
    site, errors = ::V1::Sites::UpsertSite.new(site_params).exec
    render json: { 
                  errors: Array(errors),
                  status: site ? 200 : 500
                 }.merge(V1::SiteSerializer.new(site).serializable_hash)
  end

  def site_params
    params.require(:site).permit(:site_key, :name, :region)
  end

  def load_sites
    @sites = Site.all
  end
end
