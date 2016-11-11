#!/usr/bin/ruby
#
# Bocher Diedrich Sandmeier

class RNAConverter
    
    def initialize()
       @file = readfile()
       @converted_lines = []        
    end
  
    def readfile()
        
        if ARGV.length != 1
            STDERR.puts "Usage: #{$0} Filename"
            exit 1
        end
        
        filename = ARGV[0]

        if File.exist?(filename)
            begin
                file = File.new(filename,"r")
            rescue => err
                STDERR.puts "Cannot open file #{filename}: #{err}"
                exit 1
            end
        else
            STDERR.puts "File #{filename} does not exist!"
            exit 1
        end    
        
        return file
    end
    
    def convert!()
        lines = @file.readlines
        @converted_lines[1] = ""
        lines.each {|line|
                    if line.start_with?("\>")
                        @converted_lines[0] = line.chomp! + ", untranslated regions in lower case"
                    else
                        @converted_lines[1] += line # in case the sequence spans several lines                        
                    end
                   }     
        @converted_lines[1].downcase!
        @converted_lines[1].gsub!(/aug\w{3}*?(uaa|uag|uga)/) {|coding_seq| coding_seq.upcase}   # "*?": non-greedy match,                            
                                                                                                # stops after first match
    end
    
    def output!()
        puts @converted_lines
    end

end

####

mrna = RNAConverter.new()

mrna.convert!()
mrna.output!()