require 'yaml'
require 'pp'

t = YandexTranslator::Translator.new(Rails.application.secrets.yandex_key)
lang_list_en_raw = t.lang_list('en')['langs']
lang_list_ru_raw = t.lang_list('ru')['langs']

LANG_LIST_RAW = {en: lang_list_en_raw, ru: lang_list_ru_raw}

lang_list_en = lang_list_en_raw.each.map { |key, value| [value, key]}
lang_list_en.sort!
lang_list_ru = lang_list_ru_raw.each.map { |key, value| [value, key]}
lang_list_ru.sort!

LANG_LIST =  {en: lang_list_en, ru: lang_list_ru}
