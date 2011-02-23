require 'tiny_tooltip'
require 'test/unit'

class TinyTooltipTest < Test::Unit::TestCase
  
  def test_should_match_and_replace_only_one
    page = "This page should talk about my magazine which is great by the way"
    keywords = [{:id => 1, :html => "Magazine", :summary => "Wired Magazine"}]
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/(\<a href='#' class='tooltip').*(id='magazine')/, tooltip.replace)
  end
  
  def test_should_match_and_replace_multiple
    page = "This is a test which has one magazine and one ruby programmer"
    keywords = [{:id => 1, :html => "Magazine", :summary => "Sweet Magazine"}, 
                {:id => 2, :html => "Ruby", :summary => "Ruby's great!"}]
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/(\<a href='#' class='tooltip').*(id='magazine').*(id='ruby')/, tooltip.replace)
  end
  
  def test_should_not_fail_with_nothing_to_replace
    page = "My page uses Ruby and Ruby on Rails. Ruby is the language and Ruby on Rails is the framework."
    keywords = [{:id => 1, :html => "Magazine", :summary => "Wired Magazine"}]
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/My page uses Ruby and Ruby on Rails/, tooltip.replace)
  end
  
  def test_on_nil_keywords
    page = "My page uses Ruby and Ruby on Rails. Ruby is the language and Ruby on Rails is the framework."
    keywords = []
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/My page uses Ruby and Ruby on Rails/, tooltip.replace)
  end
  
  def test_should_match_one_from_two
    page = "This page should talk about my magazine which is great by the way"
    keywords = [{:id => 1, :html => "Ruby", :summary => "Ruby's great!"}, 
                {:id => 2, :html => "Magazine", :summary => "Wired Magazine"}]
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/(\<a href='#' class='tooltip').*(id='magazine')/, tooltip.replace)
  end
  
  def test_replace_all_four
    page = "Empresa clientes 10 anos. Peter."
    keywords = [{:id => 1, :html => "empresa", :summary => "EMPRESA"}, 
                {:id => 2, :html => "clientes", :summary => "CLIENTES"},
                {:id => 3, :html => "anos", :summary => "ANOS"},
                {:id => 4, :html => "peter", :summary => "PETER"}] 
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/(\<a href='#' class='tooltip').*(id='empresa').*(id='clientes').*(id='peter')/, tooltip.replace)
  end

  def test_replace_three_last_not_found_error
    page = "Empresa clientes 10 anos. Peter." 
    keywords = [{:id => 1, :html => "empresa", :summary => "EMPRESA"}, 
                {:id => 2, :html => "clientes", :summary => "CLIENTES"},
                {:id => 3, :html => "anos", :summary => "ANOS"}, 
                {:id => 4, :html => "test", :summary => "TEST"}]
    tooltip = TinyTooltip.new(page, keywords)
    assert_match(/(\<a href='#' class='tooltip').*(id='empresa').*(id='clientes').*(id='anos')/, tooltip.replace)
  end
    
end