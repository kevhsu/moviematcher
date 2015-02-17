require 'json'

movie_file = File.read('movies.json')
movie_hash = JSON.parse(movie_file)
movie_title_hash = {}
#read all movies into title to id hash
movie_hash.each do |array|
	movie_title_hash[array['title']] = array['tms_id']
end
video_file = File.read('videos.json')
video_hash = JSON.parse(video_file)
video_hash.each do |j|
	#check for this specific title in the movie title hash
	if movie_title_hash.has_key?(j['title'])
		puts j['title']
		puts movie_title_hash[j['title']]
	end
end