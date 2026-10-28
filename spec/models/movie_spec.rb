require 'rails_helper'
require 'spec_helper'

describe Movie, type: :model do
  describe 'searching TMDb by keyword' do

    it 'calls Faraday to search TMDb' do
      expect(Faraday).to receive(:get).and_call_original

      Movie.find_in_tmdb(
        { title: 'hacker', language: 'en' },
        'test-key'
      )
    end

    it 'returns unsaved Movie objects' do
      movies = Movie.find_in_tmdb(
        { title: 'Olympics', release_year: '2000', language: 'en' },
        'test-key'
      )

      expect(movies.length).to eq(2)
      expect(movies).to all(be_a(Movie))
      expect(movies).to all(be_new_record)
      expect(movies.map(&:rating)).to all(eq('R'))
    end

    it 'includes the release year in the API request' do
      Movie.find_in_tmdb(
        { title: 'Manhunter', release_year: '1986', language: 'en' },
        'test-key'
      )

      expect(
        a_request(:get, 'https://api.themoviedb.org/3/search/movie')
          .with(query: {
            'api_key' => 'test-key',
            'query' => 'Manhunter',
            'year' => '1986',
            'language' => 'en-US'
          })
      ).to have_been_made
    end

    it 'returns an empty array when no movies are found' do
      stub_request(:get, %r{\Ahttps://api\.themoviedb\.org/3/search/movie})
        .to_return(
          status: 200,
          body: JSON.generate({ results: [] }),
          headers: { 'Content-Type' => 'application/json' }
        )

      movies = Movie.find_in_tmdb(
        { title: 'Nonexistent Movie' },
        'test-key'
      )

      expect(movies).to eq([])
    end

  end
end
