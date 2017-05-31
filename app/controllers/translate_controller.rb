# require 'yandex_translator'

class TranslateController < ApplicationController
  attr_accessor :text, :key, :out, :inp, :inp_lang, :out_lang

  # def index
  # end

  def index
    if request.post?
      key_define
      t = YandexTranslator::Translator.new(@key)
      @inp = params[:input]
      @inp_lang = params[:input_lang]
      @out_lang = params[:output_lang]
      lang = if @inp_lang
        @out_lang
      else
        @inp_lang + '-' + @out_lang
      end
      @out = !@inp.blank? ? t.translate(params[:input], lang) : nil
      # @out = t.translate(params[:input], 'en')
      # redirect_to root_path
      # redirect_to temp_path
    else
    end
  end

  def key_define
    @key = 'trnsl.1.1.20170512T143138Z.5362d1c74bf6990b.c6041721d49c95b672f7bd37b79a462b981f5423'
  end

  # def temp
  #   @out
  # end
end
