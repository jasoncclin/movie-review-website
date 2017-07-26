class PagesController < ApplicationController
	require "net/http"
	require "json"
  def home
    @theatreTitles = JSON.parse(Net::HTTP.get(URI('https://api.themoviedb.org/3/movie/now_playing?api_key=946f9f3572e6d4c2d52768418fa0c39c&language=en-US&page=1')))
    @titles = []
    @titles = @theatreTitles['results']
  end

  def searchresults
	@APIKey = "946f9f3572e6d4c2d52768418fa0c39c"
	@searchBarKeyword = params[:search]
	@reqPrimed = @searchBarKeyword.sub ' ', '%20'
	@apiReq = 'https://api.themoviedb.org/3/search/multi?api_key=' + @APIKey + "&query=" + @reqPrimed
	@APIresponse = JSON.parse(Net::HTTP.get(URI(@apiReq)))
	@arr = []
	@arr= @APIresponse['results']
  @totRes = @APIresponse['total_results']
  end

  def movie
  	@id = params[:id]
  	@title = params[:title]
  	@poster_path = params[:poster_path]
  	@picture = "https://image.tmdb.org/t/p/w500" + @poster_path
  	@overview = params[:overview]
  	@release_date = params[:release_date]
  end
end