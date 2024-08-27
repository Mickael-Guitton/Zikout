class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @results = PgSearch.multisearch(params[:query])
    @events = @results.select { |result| result.searchable_type == "Event" }.map(&:searchable)
    @venues = @results.select { |result| result.searchable_type == "Venue" }.map(&:searchable)
    @users = User.where("name ILIKE ? OR city ILIKE ? OR styles @> ?", "%#{params[:query]}%", "%#{params[:query]}%", "#{[params[:query]].to_json}")
  end
end
