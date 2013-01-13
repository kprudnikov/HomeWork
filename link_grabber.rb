#test comment

require 'open-uri'

if ARGV[0]
  url = ARGV[0]
else
  puts "No URL! Please try again, do not forget to enter the URL"
  exit
end

open(url) { |page| page_content = page.read() 
  links = page_content.scan(/href="(.*?)"/).flatten
File.open("grab.txt", "w") do |f|
  f.puts "Links from " + url + " :"
  links.each {|link| f.puts link}
end
}
