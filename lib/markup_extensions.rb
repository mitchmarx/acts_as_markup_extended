ActsAsMarkup.require_all_libs_relative_to __FILE__, 'markup_methods'
ActsAsMarkup.require_all_libs_relative_to "lib/.", 'markup_methods'

module MarkupExtensions
  class MString < String
    include MarkupExtensionMethods
    
    def run_methods(methods) 
      (methods == :all ?
        MarkupExtensionMethods.instance_methods :
        methods
      ).inject(self) { |mstring, meth|
        if mstring.respond_to? meth
          MString.new(mstring.send(meth))
        else
          raise ActsAsMarkup::UnknownExtensionMethod,
           "Extension method \"#{meth.to_s}\" is not defined " 
          MString.new(mstring)
        end
        }
    end

  end
end