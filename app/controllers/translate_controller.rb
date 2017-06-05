class TranslateController < ApplicationController
  attr_accessor :out, :lang_list

  before_action :lang_list

  @@lang_list = nil

  def lang_list
    unless @@lang_list
      key = key_define
      t = YandexTranslator::Translator.new(key)

      begin
        @@lang_list = t.lang_list('en')['langs']
        @@lang_list = @@lang_list.each.map { |key, value| [value, key]}
        @@lang_list.sort!
      rescue YandexTranslator::YandexError => e
        @@lang_list = []
        flash.now[:danger] = e.message
      else
        # Other exceptions
      end
    end
    @lang_list = @@lang_list
  end

  def index
    if request.post?
      key = key_define
      t = YandexTranslator::Translator.new(key)
      params[:input]
      lang = if params[:input_lang]
               params[:output_lang]
             else
               params[:input_lang] + '-' + params[:output_lang]
             end
      begin
        @out = params[:input].blank? ? nil : t.translate(params[:input], lang)
      rescue YandexTranslator::YandexError => e
        @out = ''
        flash.now[:danger] = e.message
      end
    else
      # for get requests
    end
  end

  def key_define
    'trnsl.1.1.20170512T143138Z.5362d1c74bf6990b.c6041721d49c95b672f7bd37b79a462b981f5423'
  end
end
