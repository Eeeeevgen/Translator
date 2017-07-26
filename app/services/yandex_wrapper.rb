class YandexWrapper
  class << self
    # attr_accessor :out, :detected, :error

    def translate(input, input_lang, output_lang)
      key = Rails.application.secrets.yandex_key
      t = YandexTranslator::Translator.new(key)

      lang = if input_lang
               output_lang
             else
               input_lang + '-' + output_lang
             end

      begin
        @output = input.blank? ? nil : t.translate(input, lang, options: 1)
        @detected = t.detected
        @error = nil
      rescue YandexTranslator::YandexError => e
        @output = nil
        @detected = nil
        @error = { type: :danger, message: e.message }
      end

      { output: @output, detected: @detected, error: @error }
    end
  end
end