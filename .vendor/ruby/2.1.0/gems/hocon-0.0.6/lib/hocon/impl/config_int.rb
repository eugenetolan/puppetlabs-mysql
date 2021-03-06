require 'hocon/impl'
require 'hocon/impl/config_number'
require 'hocon/config_value_type'

class Hocon::Impl::ConfigInt < Hocon::Impl::ConfigNumber
  def initialize(origin, value, original_text)
    super(origin, original_text)
    @value = value
  end

  def value_type
    Hocon::ConfigValueType::NUMBER
  end

  def unwrapped
    @value
  end

  def transform_to_string
    s = super
    if s.nil?
      self.to_s
    else
      s
    end
  end

  def new_copy(origin)
    Hocon::Impl::ConfigInt.new(origin, @value, @original_text)
  end
end