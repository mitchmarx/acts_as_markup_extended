module MarkupExtensionMethods
  
  # This sample extension allows list elements to act as a checklist.
  # If the markup list indicator is followed by a disposition character
  # and a space, this method will make checklist substitutions.
  #  
  # For example, when this method sees this in a Markdown list:
  #  '- x item one' 
  # or this in a Textile list:
  #  '* x item one" 
  # it will substitute: 
  #  '<li <strong>(x)</strong> item one'.
  # 
  # This method recognizes these disposition characters.
  #  x - item completed
  #  0 - item dropped
  #  d - item deferred
  #  @ - item in progress
  #
  # (this extension can be used for any markup language.)
  #
  def checklist
    gsub(/<li>([x0d@]) (\S)/)  {
      m1 = $1;m2 = $2
      m1 = ">" if m1 == "d"
      "<li><strong>(#{m1.upcase}) </strong>#{m2}"
    }
  end

end