class YmlTranslate
  class << self
    ## Дичь!
    #
    # def main(data,  input_lang, output_lang)
    #   out_tree = nil
    #   dict = {}
    #
    #   traverse(data, []) do |node, path, hash|
    #     path_new = []
    #     path.each do |p|
    #       unless p.is_a? Integer
    #         if dict[p]
    #           path_new.push(dict[p])
    #         else
    #           o = YandexWrapper.translate(p, input_lang, output_lang)
    #           path_new.push(o[:output])
    #           dict[p] = o[:output]
    #         end
    #       else
    #         path_new.push(p)
    #       end
    #     end
    #     path = path_new
    #
    #     o = YandexWrapper.translate(node, input_lang, output_lang)
    #     node = o[:output]
    #
    #     unless out_tree
    #       if path[0].is_a? Integer
    #         out_tree = []
    #       else
    #         out_tree = {}
    #       end
    #     end
    #
    #     current_node = nil
    #     path.each_with_index do |p, i|
    #       unless current_node
    #         current_node = out_tree
    #       end
    #       unless current_node[p]
    #         if i < path.size - 1
    #           if path[i + 1].is_a? Integer
    #             current_node[p] = []
    #           else
    #             current_node[p] = {}
    #           end
    #         else
    #           if hash
    #             current_node[p] = {node => nil}
    #           else
    #             current_node[p] = node
    #           end
    #         end
    #       end
    #       current_node = current_node[p]
    #     end
    #   end
    #   out_tree
    # end

    def traverse(obj, path, hash = nil, &blk)
      case obj
        when Hash
          obj.each do |k, v|
            blk.call(k, path, hash = true)
            traverse(v, path + [k], &blk)
          end
        when Array
          obj.each_with_index {|v, i| traverse(v, path + [i], &blk) }
        else
          blk.call(obj, path)
      end
    end
  end
end