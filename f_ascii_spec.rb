class String
  def remove_firstascii(replacement)
    res = ""
    self.each_byte do |c|
      if c < 32 || (c > 128 && c < 191) then
        res << replacement
      else
        puts c
        res << c
      end
    end
    res
  end

  # n=self.split("")
  # self.slice!(0..self.size)
  # n.each{|b|
  #   if b[0].to_i< 32 then
  #   # if b[0].to_i< 33 || b[0].to_i>127 then
  #    # self.concat(replacement)
  #    self.concat(b.to_i)
  #  else
  #    self.concat(b.to_i)
  #    # self.concat(b)
  #  end
  #  }
  #  self.to_s
  # end
end

require 'rubygems'
require 'sinatra'
# require File.dirname(__FILE__) + '/lib/taxon_finder_client'
# require File.dirname(__FILE__) + '/lib/neti_taxon_finder_client'
require 'nokogiri'
require 'uri'
require 'open-uri'
require 'base64'
require 'builder'
require 'active_support'
require 'ruby-debug'
require 'test/unit'
# require 'ruby-debug'
# require 'nokogiri'

 class TestAsciify < Test::Unit::TestCase
   def test_asciify
     assert_equal "I÷ÕõÓnãÕiýÏßÍizëÕiøî".remove_firstascii("?"), ""
#      assert_equal "I÷ÕõÓnãÕiýÏßÍizëÕiøî".remove_firstascii("?"),
# "I?t?rn?ti?n?liz?ti?n"
#      assert_equal "Möôorhead".remove_firstascii("(removed)"), "M(removed)torhead"
   end
 end
 
describe "remove first ascii" do
  
TEST_ALL  = 'abcd'
TEST_HTML = '/Library/Webserver/Documents/animalia.html'
TEST_TEXT = '/Library/Webserver/Documents/bit.txt'

  it "should return all text from Nokogiri" do
    params = {}
    params[:url] = TEST_TEXT
    begin
      content = params[:text] || params[:url] || params[:encodedtext] || params[:encodedurl]
    rescue
      status 400
    end
    content = URI.unescape content
    # decode if it's encoded
    content = Base64::decode64 content if params[:encodedtext] || params[:encodedurl]
    # scrape if it's a url
    if params[:encodedurl] || params[:url]
      begin
        response = open(content)
      rescue
        status 400
      end
      # resp1 = Nokogiri::HTML(response)
      pure_text = open(content).read
    
    if pure_text.include?("<html>")    
      puts "1" * 80
      # puts resp1
      # puts resp1.to_s.include?("<html>")
      # puts resp.include?("<html>")
      # content
      puts Nokogiri::HTML(response)
      # content = resp1.content 
      # puts resp1
    else
      puts "2" * 80
      puts pure_text
      content = pure_text
      # puts content
    end
      # if response.read.include?("<html>")
      #   puts "=" * 80
        # puts content.css("html")
      # end
    end
    # text2 = content
    # puts text1
    # puts "=" * 80
    # puts text2
    # response.read.should == ("<html><head>")

    content.should == ("Isognomon radiatus")
  end
 
  # it "should remove all non ASCII/non UTF-8 symbols" do
  #   # assert_equal "I÷ÕõÓnãÕiýÏßÍizëÕiøî".remove_firstascii("?"), ""
  #   # "I÷ÕõÓnãÕiýÏßÍizëÕiøî".remove_firstascii("?").should == ""
  #   TEST_TEXT.remove_firstascii("?").should == ""
  #   # " ^^^^^■W^ \IT ^1^ Jll^fl^V ".remove_firstascii("?").should == ""
  #   # TEST_ALL.remove_firstascii("").should == ""
  #   # assert last_response.body.include?('<verbatim>Volutharpa ampullacea</verbatim>')
  # end  

end
