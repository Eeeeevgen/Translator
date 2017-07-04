class YandexWrapper
  @@lang_list = nil
  @@lang_list_raw = nil
  @@error = nil
  @@detected = nil

  def self.lang_list
    @@lang_list = lang_list_raw[I18n.locale]
    @@lang_list = @@lang_list.each.map { |key, value| [value, key]}
    @@lang_list.sort!
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
      out = input.blank? ? nil : t.translate(input, lang, options: 1)
      # puts t.detected
      @@detected = t.detected
      @@error = nil
    rescue YandexTranslator::YandexError => e
      out = ''
      @@error = {type: :danger, message: e.message}
    end
    out
  end

  def self.error
    @@error
  end

  def self.detected
    @@detected
  end

  protected
    def key_define
      Rails.application.secrets.yandex_key
    end

    def self.lang_list_raw
      unless @@lang_list_raw
        puts "LANGS RELOAD"
        @@lang_list_raw = YAML.load_file("app/assets/yml/lang_list.yml")
      end
      @@lang_list_raw
    end
end
