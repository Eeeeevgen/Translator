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
    else
      # for get requests
    end
  end
end
