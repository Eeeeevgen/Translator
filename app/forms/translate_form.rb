class TranslateForm < Reform::Form
  include Reform::Form::ActiveModel

  property :input_lang
  property :output_lang
  property :input
  property :output
  property :user_id

  # validates :input_lang, presence: true
  # validates :output_lang, presence: true
  # validates :input, presence: true
  # validates :output, presence: true
  # validates :user_id, presence: true

  validation do
    required(:input_lang).filled
    required(:output_lang).filled
    required(:input).filled
    required(:output).filled
    required(:user_id).filled
  end
end