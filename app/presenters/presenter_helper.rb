module PresenterHelper
  def display_text(text)
    text.present? ? text : "-"
  end
end
  