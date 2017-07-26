class TranslateController < ApplicationController
  def index
    @form = TranslateForm.new(Translation.new)
    @lang_list = LANG_LIST[I18n.locale]

    if request.post?
      translation = YandexWrapper.translate(params[:translate][:input],
                                     params[:translate][:input_lang],
                                     params[:translate][:output_lang])
      if translation[:error]
        flash.now[translation[:error][:type]] = translation[:error][:message]
      else
        params[:translate][:output] = translation[:output]

        if params[:translate][:input_lang].blank?
          params[:translate][:input_lang] = translation[:detected]
        end

        if @form.validate(params[:translate])
          @form.save
        end

        @form = TranslateForm.new(Translation.new)
      end
    elsif request.get?
      @form = TranslateForm.new(Translation.new)
      params[:translate] = {}
    end
  end
end
