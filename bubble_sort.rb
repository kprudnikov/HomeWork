#test comment
# test master

time1 = Time.now
class Array
  def get_array(string)
    array_source = string.scan(/\d+/)
    array_source.map!{|i| i.to_i}
  end

  def swap!(a,b)
  self[a], self[b] = self[b], self[a]
  self
  end
end

source = File.read("source_int_file.txt")

array_source = Array.new
array_source = array_source.get_array(source)
count = 0
swaps = 0
for count in 0..array_source.size - 1
  for i in 0..array_source.size - 2 - count
    if array_source[i] > array_source[i+1]
      array_source.swap!(i, i+1)
      swaps += 1
    else
      next
    end
  end
  if swaps == 0
    break
  end
  count += 1
end

sortedFile = File.new("bubble_sorted.text", "w")
array_source.each{|i| sortedFile.write(i.to_s + "\n")}
time2 = Time.now
puts time2 - time1
