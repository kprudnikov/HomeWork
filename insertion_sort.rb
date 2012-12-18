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

for i in 0..array_source.size - 2
  if array_source[i] < array_source[i + 1]
    next
  else
    array_source.swap!(i, i + 1)
    k = i
    until array_source[k] > array_source[k - 1] || k < 1
      array_source.swap!(k, k - 1)
      k -= 1

    end
  end
end
  
sorted_file = File.new("insertion_sorted.text", "w")
array_source.each{|i| sorted_file.write(i.to_s + "\n")}
sorted_file.close
time2 = Time.now
puts time2 - time1
