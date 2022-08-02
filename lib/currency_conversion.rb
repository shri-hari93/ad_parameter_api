# frozen_string_literal: true

module CurrencyConversion
  CONVERSION_RATE = { "TYR" => 3.31, "USD" => 1.13, "SEK" => 10.36, "EUR" => 1 }.freeze

  def convert_to_euro(price, code)
    price.to_f / CONVERSION_RATE[code]
  end
end
