module PropertiesHelper
  def trans val
    if val.class === true
        "Yes"
    elsif val.class === false
        "No"
    else
      val
    end
  end
  def show_field(lable, value)
    "<div class='span12 amenities-block'><div class='span3'><b class='property_details_label'>#{lable}</b></div><div class='sapn3'>#{trans(value)}</div></div>".html_safe unless value.to_s.empty?
  end
end
