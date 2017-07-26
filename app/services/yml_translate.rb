require 'pp'

class YmlTranslate
  class << self
    def traverse_list(obj)
      case obj
        when Hash
          temp = []
          obj.each do |k, v|
            temp.push k
            temp.push traverse_list(v)
          end
          return temp
        when Array
          temp = []
          obj.each do |v|
            temp.push traverse_list(v)
          end
          return temp
        else
          return obj
      end
    end

    def traverse(obj, dict)
      case obj
        when Hash
          temp = {}
          obj.each do |k, v|
            temp[dict[k]] = traverse(v, dict)
          end
          return temp
        when Array
          temp = []
          obj.each do |v|
            temp.push traverse(v, dict)
          end
          return temp
        else
          return dict[obj]
      end
    end

    # def traverse(obj, input_lang, output_lang)
    #   case obj
    #     when Hash
    #       temp = {}
    #       obj.each do |k, v|
    #         t = YandexWrapper.translate(k, input_lang, output_lang)
    #         temp[t[:output]] = traverse(v, input_lang, output_lang)
    #       end
    #       temp
    #     when Array
    #       temp = []
    #       obj.each do |v|
    #         temp.push traverse(v, input_lang, output_lang)
    #       end
    #       temp
    #     else
    #       t = YandexWrapper.translate(obj, input_lang, output_lang)
    #       t[:output]
    #   end
    # end

    def tr(obj, input_lang, output_lang)
      list = traverse_list(obj).flatten
      t = YandexWrapper.translate(list, input_lang, output_lang)
      dict = Hash[list.zip t[:output]]
      traverse(obj, dict)
    end
  end
end