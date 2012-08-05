require 'fleakr'
#require 'ruby-debug';

Fleakr.api_key = ENV['FLICKR_API_KEY'] || 'your_key_here'

user_name = "Nicole takes pictures"
set_name = "self portraits"

Dir.mkdir("./albums") unless File.exists?("./albums")

# Find a user
user = Fleakr.user(user_name)

# Grab a set from the list
set = user.sets.select{|set| set.is_a?(Fleakr::Objects::Set) && set.title && set.title.match(/#{set_name}/i) }.first

puts set.title        # => "Rails Rumble 2008"
puts set.description  # => "Multiple Viget teams (and friends) ..."

# Inspect a photo
photos = set.photos

Dir.mkdir("./albums/#{user_name.gsub(" ",'_')}") unless File.exists?("./albums/#{user_name.gsub(" ",'_')}")
photos.each do |photo|
  puts photo.title       # => "Fast and Furious"
  #puts photo.description # => "Off to a good start on day #1"

  # Save an individual image to disk
  if photo.original
    photo.original.save_to("./albums/#{user_name.gsub(" ",'_')}/#{photo.title}.jpg")
  elsif photo.large
    photo.large.save_to("./albums/#{user_name.gsub(" ",'_')}/#{photo.title}.jpg")
  elsif photo.medium
    photo.medium.save_to("./albums/#{user_name.gsub(" ",'_')}/#{photo.title}.jpg")
  elsif photo.small
    photo.small.save_to("./albums/#{user_name.gsub(" ",'_')}/#{photo.title}.jpg")
  end
end

puts "done"
