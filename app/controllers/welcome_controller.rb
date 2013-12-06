class WelcomeController < ApplicationController
  def index
    @people = Person.where('longitude IS NOT NULL AND latitude IS NOT NULL')
    @markers = Gmaps4rails.build_markers(@people) do |person, marker|
      marker.lat person.latitude
      marker.lng person.longitude
      marker.title person.name
      marker.picture person.picture
    end
  end
end