require 'yaml'

class Api::V1::TranslateController < Api::V1::BaseController
  def translate
    if params[:yaml]
      # data = YAML.load(params[:yaml].tempfile)
      #
      # out_tree = YmlTranslate.main(data, params[:input_lang], params[:output_lang])
      #
      # # render plain: 'ok'
      # render plain: out_tree.to_yaml, :content_type => 'text/yaml'
    else
      o = YandexWrapper.translate(params[:input], params[:input_lang], params[:output_lang])
      render json: o[:output], status: 200
    end
  end
end