module Solargraph
  module Pin
    class Attribute < Base
      # @return [Symbol] :reader or :writer
      attr_reader :access

      def initialize source, node, namespace, access, docstring
        super(source, node, namespace)
        @access = access
        @docstring = docstring
      end

      def name
        @name ||= "#{node.children[0]}#{access == :writer ? '=' : ''}"
      end

      def path
        @path ||= namespace + '#' + name
      end

      def return_type
        if @return_type.nil? and !docstring.nil?
          tag = docstring.tag(:return)
          @return_type = tag.types[0] unless tag.nil?
        end
        @return_type
      end

      def completion_item_kind
        Solargraph::LanguageServer::CompletionItemKinds::PROPERTY
      end

      def method?
        true
      end
    end
  end
end
