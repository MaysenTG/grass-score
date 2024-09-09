module ApplicationHelper
  def number_to_currency(number)
    is_negative = number < 0
    absolute_number = number.abs

    if absolute_number >= 1000
      abbreviated_number = (absolute_number / 1000).to_i
      formatted_number = "#{abbreviated_number}K"
    else
      formatted_number = super(absolute_number)
    end

    is_negative ? "-#{formatted_number}" : formatted_number
  end
end
