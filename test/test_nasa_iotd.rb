require 'minitest/autorun'
require './lib/nasa_iotd.rb'

class TestNASAIOTD < MiniTest::Unit::TestCase

  def test_today
    today = NASAIOTD.new.today
    assert_equal 'http://', today.fetch(:uri).slice(0, 7)
    assert_equal '.jpg', today.fetch(:uri).slice(-4, 4)
    assert_respond_to(today, :download)
  end

end