class YandexWrapper
  @@lang_list = nil

  def self.lang_list
    unless @@lang_list
      puts "RELOAD!!"
      key = Rails.application.secrets.yandex_key
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
    @@lang_list
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

  # class << self
  #   attr_accessor :lang_list
  # end
  # @lang_list = '123ooo'

  # @@lang_list = '456ttt'

  protected
    def key_define
      Rails.application.secrets.yandex_key
    end
end
