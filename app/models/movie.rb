require 'json'

class Movie < ActiveRecord::Base

  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end

  def self.find_in_tmdb(search_params, api_key = ENV['TMDB_API_KEY'])

    # Support the string argument used in earlier controller tests.
    if search_params.is_a?(String)
      search_params = { title: search_params }
    end

    title = search_params.fetch(:title).to_s.strip

    raise ArgumentError, 'Movie title is required' if title.empty?
    raise ArgumentError, 'TMDB_API_KEY is missing' if api_key.to_s.empty?

    url = 'https://api.themoviedb.org/3/search/movie'

    query = {
      api_key: api_key,
      query: title
    }

    # Release year is optional.
    release_year = search_params[:release_year].to_s.strip

    unless release_year.empty?
      query[:year] = release_year
    end

    # Apply English language filter if selected.
    if search_params[:language] == 'en'
      query[:language] = 'en-US'
    end

    # Send request to TMDb.
    response = Faraday.get(url, query)

    unless response.status == 200
      raise "TMDb request failed with HTTP #{response.status}"
    end

    # Parse JSON response.
    data = JSON.parse(response.body)

    # Convert results into unsaved Movie objects.
    movies = data.fetch('results', []).map do |result|
      Movie.new(
        title: result['title'],
        rating: 'R',
        release_date: result['release_date'].presence,
        description: result['overview']
      )
    end

    movies
  end

end
