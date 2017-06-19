class TranslateController < ApplicationController
  attr_accessor :out, :lang_list

  before_action :lang_list

  @@lang_list = nil

  def lang_list
    @lang_list = YandexWrapper.lang_list
  end

  def index
    if request.post?
      @out = YandexWrapper.translate(params[:input], params[:input_lang], params[:output_lang])
      if current_user
        current_user.translations.create(input_lang: params[:input_lang], output_lang: params[:output_lang], input: params[:input], output: @out)
      end
    else
      # for get requests
    end
  end
end
