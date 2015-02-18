require 'json'

def convert_roman(s)
	last_word = s.split.last
	case last_word
	when "I"
		return s[0..-2]+"1"
	when "II"
		return s[0..-3]+"2"
	when "III"
		return s[0..-4]+"3"
	when "IV"
		return s[0..-3]+"4"
	when "V"
		return s[0..-2]+"5"
	else
		return s
	end
end

def clean_moviename(s)
	retval = String.new
	if s[-1,1] == ")"
		return convert_roman( s.gsub(/\([^)]+\)+/,'') ).downcase
	else
		return convert_roman(s).downcase
	end
end

movie_file = File.read('movies.json')
movie_hash = JSON.parse(movie_file)
movie_title_hash = {}
movie_year_hash = {}
#read all movies into title to id hash
movie_hash.each do |array|
	movie_title_hash[array['title']] = array['tms_id']
	movie_year_hash[array['title']] = array['year']
end
video_file = File.read('videos.json')
video_hash = JSON.parse(video_file)
video_hash.each do |j|
	#check for this specific title in the movie title hash
	if movie_title_hash.has_key?(j['title']) and (j['year']==movie_year_hash[j['title']])
		puts j['year']
		puts movie_year_hash[j['title']]
		puts j['title']
		puts movie_title_hash[j['title']]
	else
		puts "****** #{j['title']} has no match"
	end
end