module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def formatted_price(property)
    if I18n.locale == :en
      property.english_formatted_price
    else
      property.chineese_formatted_price
    end
  end

end
