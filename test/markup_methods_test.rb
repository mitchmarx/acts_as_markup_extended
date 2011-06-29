require File.dirname(__FILE__) + '/test_helper'

include MarkupExtensionMethods

class MarkupMethodsTest < ActsAsMarkupTestCase
  
  context "checklist" do
    setup do
        @no_disposition  = %Q~<li> test </li>~
        @deferred_in     = %Q~<li>d test</li>~
        @deferred_out    = %Q~<li><strong>(>) </strong>test</li>~
        @completed_in    = %Q~<li>x test</li>~
        @completed_out   = %Q~<li><strong>(X) </strong>test</li>~
        @in_progress_in  = %Q~<li>@ test</li>~
        @in_progress_out = %Q~<li><strong>(@) </strong>test</li>~
        @dropped_in      = %Q~<li>0 test</li>~
        @dropped_out     = %Q~<li><strong>(0) </strong>test</li>~
        @not_disp_char   = %Q~<li>% test</li>~
    end
     
    should "leave list item without disposition character unchanged" do
      assert_equal @no_disposition, @no_disposition.checklist
    end
    
    should "put parens around list item with 'd' disposition character" do
      assert_equal @deferred_out, @deferred_in.checklist
    end
    
    should "put parens around list item with 'x' disposition character" do
      assert_equal  @completed_out, @completed_in.checklist
    end
    
    should "put parens around list item with '@' disposition character" do
      assert_equal @in_progress_out, @in_progress_in.checklist
    end
    
    should "put parens around list item with '0' disposition character" do
      assert_equal @dropped_out, @dropped_in.checklist
    end
    
    should "leave list item with a character other than disp character unchanged" do
      assert_equal @not_disp_char, @not_disp_char.checklist
    end  
  end
  
  context "ahttp" do
    setup do
      @simple_href_in   = %Q~http://www.google.com~
      @simple_href_out  = %Q~<a href="http://www.google.com">http://www.google.com</a>~
      @href_with_spaces = %Q~<a href = "    http://www.google.com   ">google</a>~
      @img              = %Q~<img alt="alt text" title="Title"~ +
                          %Q~ src="http://www.textism.com/common/textist.gif">~
      @code             = %Q~<code>&lt;http://www.google.com </code>~
      @pre              = %Q~<pre>&lt;http://www.google.com </pre>~
    end

    should "make href from text" do
      assert_equal @simple_href_out, @simple_href_in.ahttp
    end

    should "leave href text inside href unchanged" do
      assert_equal @simple_href_out, @simple_href_out.ahttp
    end

    should "leave href text inside href with spaces unchanged" do
      assert_equal @href_with_spaces, @href_with_spaces.ahttp
    end

    should "leave href text inside <img> tag unchanged" do
      assert_equal @img, @img.ahttp
    end

    should "leave href text inside <code> tags unchanged" do
      assert_equal @code, @code.ahttp
    end

    should "leave href text inside <pre> tags unchanged" do
      assert_equal @code, @code.ahttp
    end
  end
  
  context "logo" do
    setup do
      @logo_in   = %Q~<a href="home">logo</a>~
      @logo_out  = %Q~<a href="http://www.google.com">\n~ + 
                   %Q~<img id="logo" alt="Google"~ + 
                   %Q~ src="http://www.google.com/images/logos/google_logo.gif"~ +
                   %Q~ style="border: 0 none;">\n</a>\n~      
    end
    
    should "substitute company logo and home page link when special URL is matched"do
      assert_equal @logo_out, @logo_in.logo
    end
  end
end