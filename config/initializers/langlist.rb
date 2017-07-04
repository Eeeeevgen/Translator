require 'yaml'

t = YandexTranslator::Translator.new(Rails.application.secrets.yandex_key)
lang_list_raw_en = t.lang_list('en')['langs']
lang_list_raw_ru = t.lang_list('ru')['langs']
lang_list_raw = {en: lang_list_raw_en, ru: lang_list_raw_ru}

File.open("app/assets/yml/lang_list.yml","w") do |file|
  file.write lang_list_raw.to_yaml
  # file.write lang_list_raw_ru.to_yaml
end