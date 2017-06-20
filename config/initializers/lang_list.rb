require 'yaml'

t = YandexTranslator::Translator.new(Rails.application.secrets.yandex_key)
lang_list_raw = t.lang_list('en')['langs']

File.open("app/assets/yml/lang_list.yml","w") do |file|
  file.write lang_list_raw.to_yaml
end