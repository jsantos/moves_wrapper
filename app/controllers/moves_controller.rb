class MovesController < ApplicationController
	def index
		redirect_to "/auth/moves"
	end

	def show
		date = params[:date]
		if !date.nil?
			@storyline = current_user.moves.daily_storyline(date, :trackPoints => true)
		else
			@storyline = current_user.moves.daily_storyline(:trackPoints => true)
		end

		puts @storyline.to_json
		segments = @storyline.first["segments"]
		places = []
		trackPoints = []
		segments.each do |segment|
			if segment["type"] == "place"
				places << segment
			end

			if !segment["activities"].nil?
				segment["activities"].each do |activity|
					if !activity["trackPoints"].empty?
						trackPoints.concat(activity["trackPoints"])
					end
				end
			end
		end

		gon.track_points = trackPoints.map{ |point| {"lng" => point["lon"], "lat" => point["lat"]}}

		gon.places = Gmaps4rails.build_markers(places) { |place, marker|
  		marker.lat place["place"]["location"]["lat"]
  		marker.lng place["place"]["location"]["lon"]
  		marker.infowindow "#{DateTime.parse(place["startTime"]).in_time_zone("Singapore")} - #{DateTime.parse(place["endTime"]).in_time_zone("Singapore")}"
  	}

  	gon.markers = Gmaps4rails.build_markers(trackPoints) { |point, marker|
      marker.lat point["lat"]
      marker.lng point["lon"]
      marker.infowindow "#{DateTime.parse(point["time"]).in_time_zone("Singapore")}"
      marker.picture( {
        "url" => view_context.image_path('dot_red.png'),
        "width" =>  '16',
        "height" => '16'
      })
  	}
	end
end