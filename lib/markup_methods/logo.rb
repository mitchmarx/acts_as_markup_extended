module MarkupExtensionMethods
  
  # This sample extension inserts a company logo.
  # If Markdown contains:
  #   "[logo](home)"
  # or Textile contains:
  #   "logo":home
  # The generated HTML contains the company logo and links to the home page.
  #
  # (This extension can be used for any markup language)
  #
  def logo
    gsub( /<a href="home">logo<\/a>/ ) { 
      match = $&; before = $`
      if before !~ /(<code>|<pre>).*$/
        %Q~<a href="http://www.google.com">\n~ +
        %Q~<img id="logo" alt="Google"~ +
        %Q~ src="http://www.google.com/images/logos/google_logo.gif"~ + 
        %Q~ style="border: 0 none;">\n~ +
        %Q~</a>\n~
      else
        match
      end
    }
  end

end