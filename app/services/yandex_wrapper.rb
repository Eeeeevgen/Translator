class YandexWrapper
  @@lang_list = nil
  @@lang_list_raw = nil

  def self.lang_list
    unless @@lang_list
      @@lang_list = lang_list_raw.each.map { |key, value| [value, key]}
      @@lang_list.sort!
    end
    @@lang_list
  end

  def self.lang_decode(lang)
    if lang == ''
      return 'Auto'
    end
    lang_list_raw[lang]
  end

  def self.translate(input, input_lang, output_lang)
    key = Rails.application.secrets.yandex_key
    t = YandexTranslator::Translator.new(key)
    lang = if input_lang
             output_lang
           else
             input_lang + '-' + output_lang
           end
    begin
      out = input.blank? ? nil : t.translate(input, lang)
    rescue YandexTranslator::YandexError => e
      out = ''
      flash.now[:danger] = e.message
    end
    out
  end

  protected
    def key_define
      Rails.application.secrets.yandex_key
    end

    def self.lang_list_raw
      unless @@lang_list_raw
        puts "LANGS RELOAD"
        key = Rails.application.secrets.yandex_key
        t = YandexTranslator::Translator.new(key)

        begin
          @@lang_list_raw = t.lang_list('en')['langs']
        rescue YandexTranslator::YandexError => e
          @@lang_list_raw = []
          flash.now[:danger] = e.message
        else
          # Other exceptions
        end
      end
      @@lang_list_raw
    end
end
