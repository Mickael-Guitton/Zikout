class HomesController < ApplicationController

  def home
    @results = PgSearch.multisearch(params[:query])
    @events = @results.select { |result| result.searchable_type == "Event" }.map(&:searchable)
    @venues = @results.select { |result| result.searchable_type == "Venue" }.map(&:searchable)
  end

end
