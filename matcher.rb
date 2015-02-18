require 'json'

#if the roman numeral is above 5, there are too many darn sequels!
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

#remove parentheses at the end, make lowercase, and change roman numerals into numbers
#also, remove/replace certain symbols
def clean_moviename(s)
	return convert_roman( s.gsub(/\([^)]+\)+/,'').gsub(/\[[^)]+\]+/,'') ).\
	gsub("&", "and").gsub("$", "s").gsub("-", " ").\
	gsub("?", "").gsub(":", "").downcase.strip

end

movie_file = File.read('movies.json')
movie_hash = JSON.parse(movie_file)
movie_title_hash = {}
movie_year_hash = {}
id_to_tms_id = {}
#read all movies into title to id hash
movie_hash.each do |array|
	clean_title = clean_moviename(array['title'])
	movie_title_hash[clean_title] = array['tms_id']
end
video_file = File.read('videos.json')
video_hash = JSON.parse(video_file)
video_hash.each do |j|
	clean_title = clean_moviename(j['title'])
	#check for this specific title in the movie title hash
	if movie_title_hash.has_key?(clean_title)
		id_to_tms_id[j['id']] = movie_title_hash[clean_title]
	else
		puts "****** #{clean_title} has no match"
	end
end
puts id_to_tms_id