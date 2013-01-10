# реализовать рекурсией
# This is test comment

require 'open-uri'

def get_links(url_value)
  @url = url_value
  page = open(@url)
  text = page.read
  adress = text.scan(/<a href=["'](.*?)["']/)
  adress.flatten!
  home_url = @url.scan(/(https?:\/\/[^\/]+)(\/|$)/)
  home_url.flatten!
  adress.each do |i|
    if (i =~ /http/) != 0 && (i =~ /\/\//) != 0
      if home_url[0][-1] == "\/" && home_url[0] != nil
        home_url[0].chop!
        i.insert 0, home_url[0].to_s
      elsif home_url[0] == nil
        next
      else
      i.insert 0, home_url[0].to_s
      end
    elsif (i =~ /\/\//) == 0
      i.insert 0, "http:"
    else
      i = i
    end
  end
  adress.each do |i|
    if (i =~ /mailto.*@/) != nil
    adress.delete(i)
    elsif i == @url || i == @url +"\/"
      adress.delete(i)
    else next
    end
  end
puts adress.uniq.inspect
  return adress.uniq
end

def get_sublayer_links(url_array)
  middle_links = []
  @grabbed_links = url_array
  @grabbed_links.each{|i| middle_links += get_links(i)}
  middle_links.uniq!
end

puts "Please enter web-adress to proceed:"
url = gets.chomp!
puts "Please enter the number of sublayers to process:"
layers = gets.chomp!.to_i

if (url =~ /http/) == 0
  url = url
elsif url == ""
  puts "No data"
  abort
else
  url = url.insert 0, "http://"
end

puts "Processing #{url}"
grabbed_links = get_links(url)
puts grabbed_links.inspect

aFile = File.new("parse_links.txt", "w")
unless grabbed_links == nil || grabbed_links.size == 0
  grabbed_links.each{|i| aFile.write(i+"\n")}
else
  puts "No links"
  abort
end
aFile.close

counter = 1
used_links = grabbed_links
layers.times do
middle_links = get_sublayer_links(grabbed_links)
middle_links -= used_links
aFile = File.new("parse_links_sublayer_#{counter}.txt", "a")
middle_links.each{|i| aFile.write(i + "\n")}
aFile.close
grabbed_links = middle_links
used_links += middle_links
counter += 1
end

puts "Processing complete."