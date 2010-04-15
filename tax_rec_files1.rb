#!/usr/bin/ruby

class String
  def count_words
    n = 0
    scan(/\b\S+\b/) {n += 1}
    n
  end 
end

class Array

  require "rubygems"
  require "taxamatch_rb"
  require "text"
  require 'set'

  def reconsilliation(file_name = $*[1])
    i = 0
    arr = []
    result = []
    name_list = self
    second_list = get_name_list(file_name)
    name_list.each do |bad_name|
      set_bad_name    = bad_name.scan(/./).to_set
      count_bad_words = bad_name.count_words
      second_list.each do |good_name|
        # 1 filter
        unless bad_name == good_name
          count_good_words = good_name.count_words
          # 2 filter
          if count_bad_words == count_good_words && count_bad_words > 1
            # 3 filter
            if compare_sets(set_bad_name, good_name) < 3 
              # for Levenshtein use:          
              # arr = lev_dist_match(arr, bad_name, good_name, 3)
              # for Taxamatch use:
              # arr = taxamatch_match(arr, bad_name, good_name)
              if Taxamatch::Base.new.taxamatch(bad_name, good_name)
                text = bad_name.to_s + " ---> " + good_name.to_s
              end
              arr << text
              text = ""
            end
          end
        # else
          # arr << bad_name
        end
        
      end
      # result << arr unless arr.empty?
      result << arr.compact! 
      # .uniq if (arr.size > 1) 
      arr = []
      i += 1
    end
    puts "There were "+i.to_s+" names"
    return result
  end
 
  def take_all_names
    t1 = Time.now  
    uniq_result = []
    names_list = self
    uniq_result_all = names_list.reconsilliation.uniq  
    puts "-" * 40
    # TODO: what to print
    # names_list.each do |k|
    #     unless uniq_result_all.flatten.include? k
    #       uniq_result_all << k unless k.empty?
    #     end
    # end
    
    puts "We have " + uniq_result_all.size.to_s + " groups"
    t2 = Time.now
    t3 = t2-t1
    if t3 < 60 
      puts "The process took " + t3.to_s + " sec"
    else
      puts "The process took " + (t3 / 60).to_s + " min"
    end
    puts "-" * 40
    puts uniq_result_all.inspect.to_s
    exit
    # return uniq_result_all
  end

  private

   def parse_match(parsed_line1, parsed_line2)
     p = Taxamatch::Atomizer.new
     parsed_name1 = p.parse(parsed_line1)
     parsed_name2 = p.parse(parsed_line2)
     begin    
       t = Taxamatch::Base.new
       return t.taxamatch_preparsed(parsed_name1, parsed_name2)["match"] #true
     rescue
       return false
     end
   end

   def taxamatch_match(arr, name1, name2)
     begin        
       if Taxamatch::Base.new.taxamatch(name1, name2) then
         arr << name2
         arr << name1
       end
     rescue
       puts name1
       nil
     end
     return arr
   end

   # def taxamatch_match(arr, name1, name2)
   #   begin        
   #     
   #     if Taxamatch::Base.new.taxamatch(name1, name2) then
   #       arr << name2
   #       arr << name1
   #     end
   #   rescue
   #     puts name1
   #     nil
   #   end
   #   return arr
   # end

   def lev_dist_match(arr, name1, name2, num)
     if Text::Levenshtein.distance(name1, name2) < num
       arr << name2
       arr << name1
     end
     return arr
   end

   def compare_sets(bad_name, good_name)
     set_good_name = good_name.scan(/./).to_set  
     return set_good_name.difference(bad_name).size
   end
end

names_list = []  

def get_name_list(file_name)
    names_list = []  
    file1 = File.open(file_name, 'r')                                                    
    file1.readlines.each do |line|
      # do stuff with line

      line.chomp!
      line.gsub!(/[^A-Za-z ]/, "")
      names_list << line
    end
    return names_list
  end
  
if ARGV.size < 2
  puts "Provide two files to compare, bad and good, please"
else
  first_name = ARGV[0]
  get_name_list(first_name).take_all_names
end

# names_list = ["Plantago major", "Plantago major Linne", "Plantago majo", "Quercus Rubra"]
# p = Taxamatch::Atomizer.new
# parsed_name1 = p.parse('Monacanthus fronticinctus Günther 1867 sec. Eschmeyer 2004')
# parsed_name2 = p.parse('Monacanthus fronticinctus (Gunther, 1867)')
# t.taxamatch_preparsed(n2,n3)["match"] #true
