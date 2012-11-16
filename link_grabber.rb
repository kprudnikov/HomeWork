require 'open-uri'

if ARGV[0]
  url = ARGV[0]
else
  puts "No URL! Please try again, do not forget to enter the URL"
  exit
end

open(url) { |page| page_content = page.read() 
  links = page_content.scan(/href="(.*?)"/).flatten
  links.each {|link| puts link}
}
