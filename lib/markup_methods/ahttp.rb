module MarkupExtensionMethods
  
  # This sample extension replaces URL strings in the form:
  #   "http://..."
  # with links:
  #   "<a href="http://..."
  #
  # Strings that are already part of 
  #   <a href= ...> or <img src= ...> 
  # or inside 
  #   <code> or <pre> 
  # tags will remain unchanged
  #
  # (This extension can be used for any markup language.)
  #
  def ahttp
    gsub( /http:\/\/[^\s><"']+/ ) {
      match = $&; before = $`; after = $'     
      before !~ /\s+(href|src|)\s*=\s*['"]*$/  && 
      after  !~ /^[^<]*<\/a>/  && 
      before !~ /(<code>|<pre>).*$/         ?
        %Q~<a href="#{match}">#{match}</a>~ :
        match
    }
  end

end