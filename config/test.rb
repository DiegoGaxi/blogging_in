[3,2,7,9,5]

def sort(array)
   aux = 9999
   auxarray = []
   array.each do |number|
      aux = number if number < aux
      auxarray.push(aux) if number < aux
   end
end

sort([3,2,7,9,5])

[2,3,6,2,3] 
{2=>2,3=>2,6=>1}

def countTimes(array)
   counting = 1
   new_hash = {}
  array.each do  |number|
      array.delete(number) if array.includes?(number)
      counting+=1 if array.includes?(number)

  end
end

countTimes([2,3,6,2,3])