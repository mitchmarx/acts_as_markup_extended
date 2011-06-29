require File.dirname(__FILE__) + '/test_helper'

include MarkupExtensionMethods

class ActsAsMarkupExtendedTest < ActsAsMarkupTestCase
  
  context 'simple acts_as..' do
    setup do
      @textile_text          = %Q~* x item1~
      @markdown_text         = %Q~- x item1~
      # each markup language puts out slightly different text
      # with spaces, tabs and newlines
      @regex_out =      /^<ul>\s*<li><strong>\(X\) <\/strong>item1\s*<\/li>\s*<\/ul>\s*/
      @regex_fail_out = /<ul>\s*<li>x item1\s*<\/li>\s*<\/ul>\s*/
    end
  
    should "invoke textile extension method when :extension => [:method] " do
      class Post < ActiveRecord::Base
        acts_as_textile :body, :extensions => [:checklist]
      end
      @post = Post.create!(:title => 'textile', :body => @textile_text)
      assert_match @regex_out, @post.body.to_html
    end
    
    should "invoke markdown extension method when :extension => [:method] " do
      class Post < ActiveRecord::Base
        acts_as_markdown :body, :extensions => [:checklist]
      end
      @post = Post.create!(:title => 'Blah1', :body => @markdown_text)
      assert_match @regex_out, @post.body.to_html
    end
    
    should "invoke rdoc extension method when :extension => [:method] " do
      class Post < ActiveRecord::Base
        acts_as_rdoc :body, :extensions => [:checklist]
      end
      @post = Post.create!(:title => 'Blah2', :body => @textile_text)
      assert_match @regex_out, @post.body.to_html
    end
    
    should "invoke wikitext extension method when :extension => [:method] " do
      class Post < ActiveRecord::Base
        acts_as_wikitext :body, :extensions => [:checklist]
      end
      @post = Post.create!(:title => 'Blah3', :body => @textile_text)
      assert_match @regex_out, @post.body.to_html
    end

    should "invoke extension method when :extension => :all specified " do
      class Post < ActiveRecord::Base
        acts_as_textile :body, :extensions => :all
      end
      @post = Post.create!(:title => 'textile', :body => @textile_text)
      assert_match @regex_out, @post.body.to_html
    end    
    
    should "invoke extension method when acts_as_markup :extension => :all specified " do
      class Post < ActiveRecord::Base
        acts_as_markup :language => 'textile', :columns => [:body], :extensions => :all
      end
      @post = Post.create!(:title => 'textile', :body => @textile_text)
      assert_match @regex_out, @post.body.to_html
    end  
    
    should "invoke extension method when acts_as_markup :language_column, " +
            ":extension => :all specified " do
      class VariableLanguagePost < ActiveRecord::Base
        acts_as_markup :language => :variable, :columns => [:body], 
          :language_column => 'language_name', :extensions => :all
      end
      @post = VariableLanguagePost.create!(:title => 'textile', :body => @textile_text, 
        :language_name => 'textile')
      assert_match @regex_out, @post.body.to_html
    end

    should 'raise exception when a non-existent extension method is named' do
      class Post < ActiveRecord::Base
          acts_as_textile :body, :extensions => [:non_existent]
      end
      @post = Post.create!(:title => 'textile1', :body => @textile_text)
      assert_raise ActsAsMarkup::UnknownExtensionMethod do
          @post.body.to_html
      end
    end
          
    teardown do
      Post.delete_all
    end    
  end
end