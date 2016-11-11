#!/usr/bin/ruby
#
# Diedrich, Bocher, Sandmeier
#
# Bei der Ausfuehrung von ./randompermutation.rb 4 100000 | sort | uniq -c
# ist eine gleichmaessige Verteilung zu erwarten, also eine Haeufung von 100000 / 4! ~= 4166.67 je Permutation.
# Um die Abweichung zu quantifizieren, waere die Berechnung der Standardabweichung eine Moeglichkeit.

class RandomPermutator

  def initialize()
    @iterations = 0
    @array = Array.new
    array_size = 0
    
    if ARGV.length != 2
      STDERR.puts "Usage: #{$0} length_array no_of_permutations"
      exit 1
    end     
    
    begin
      array_size = Integer(ARGV[0])
      @iterations = Integer(ARGV[1])
      if (array_size < 0 || @iterations < 0)
	raise
      end
    rescue
      STDERR.puts "Incorrect syntax, only positive integers allowed as input!"
      exit 1
    else
      @array = Array.new(array_size)
    end   
        
  end 
  
  def fillArray!()
    0.upto(@array.size() -1) { |i|
      @array[i] = i
      }    
  end

  def permutate!()
    @iterations.times do
      randompermutation!
    end
  end

private

  def randompermutation!()
      temp_array = @array
      rg = Random.new
      temp_array.each_index{ |i|
	random_number = rg.rand(temp_array.size() - i)
	temp_array[i], temp_array[random_number] = temp_array[random_number], temp_array[i]
      }
      puts temp_array.inspect.gsub(/\[|\]|\s/, '')
  end

end
  
######  

permutator = RandomPermutator.new
permutator.fillArray!
permutator.permutate!
  
exit 0