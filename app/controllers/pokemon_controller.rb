class PokemonController < ApplicationController
  def show

    pokemon_results = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}")
    body_p = JSON.parse(pokemon_results.body)

    giphy_results = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{body_p["name"]}&rating=g")
    body_g =JSON.parse(giphy_results.body)
    gif_url = body_g["data"][0]["url"]

    pokemon = {
      id: body_p["id"],
      name: body_p["name"],
      types: body_p["types"].map { |type|
          type["type"]["name"]
        },
      gif: gif_url
    }

    render json: gif_url
  end
end
