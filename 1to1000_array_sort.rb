time1 = Time.now

class Array
  def get_array(string)
    array_source = string.scan(/\d+/)
    array_source.map!{|i| i.to_i}
  end
end

array_middle = Array.new(1000)
array_middle.map!{|i| i = 0}
arrayFile = File.new("source_int_file.txt", "w")

5000.times do
  i = rand(1..1000)
  arrayFile.write(i.to_s + "\n")
end
arrayFile.close

source = File.read("source_int_file.txt")
array_source = Array.new
array_source = array_source.get_array(source)
sortedArrayFile = File.new("sorted_array_file.txt", "w")

array_source.each{|i| array_middle[i-1] += 1}

array_middle.each_index{|i| array_middle[i].times{sortedArrayFile.write((i+1).to_s + "\n")}}
sortedArrayFile.close
time2 = Time.now
puts time2 - time1

