# Copyright (c) 2007 Thiago Jackiw
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 

class TinyTooltip
  def initialize(text, keywords)
    @text        = text
    @replaced    = false
    @replacement = nil
    @keywords    = keywords.collect{|k| [k[:html],k[:summary]]}.sort{|x,y| y[0].length <=> x[0].length} unless keywords.nil?
  end
  
  def replace
    return( @text ) if @keywords.nil?
    return( @replacement ) if @replaced
    @keywords.each_index{|w| 
      unless @text.scan(/#{@keywords[w][0]}/i).empty? 
        @replacement = @text.gsub!(/#{@keywords[w][0]}/i, get_html(@keywords[w][0],@keywords[w][1]))
      end
    }
    @replaced = true
    @replacement || @text
  end

  protected
  def get_html(word, summary)
    "<a href='#' class='tooltip'>#{word}</a><div class='poplayer' " +
    "id='#{word.downcase.gsub(" ","_")}' style=''>#{summary}</div>"
  end
end
