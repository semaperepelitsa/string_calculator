require "minitest/unit"
require "./string_calculator"

class StringCalculatorTest < MiniTest::Unit::TestCase
  def test_empty_input
    assert_equal 0, StringCalculator.add("")
  end

  def test_one_number
    assert_equal 1, StringCalculator.add("1")
  end

  def test_two_numbers
    assert_equal 3, StringCalculator.add("1,2")
  end

  def test_ten_numbers
    assert_equal 55, StringCalculator.add("1,2,3,4,5,6,7,8,9,10")
  end

  def test_newline
    assert_equal 6, StringCalculator.add("1\n2,3")
  end

  def test_custom_delimiter
    assert_equal 3, StringCalculator.add("//;\n1;2")
  end

  def test_custom_long_delimiter
    assert_equal 3, StringCalculator.add("//[***]\n1***2")
  end

  def test_multiple_custom_delimiters
    assert_equal 6, StringCalculator.add("//[*][%]\n1*2%3")
  end

  def test_custom_delimiter_leaves_input_unmodified
    input = "//;\n1;2"
    StringCalculator.add(input)
    assert_equal "//;\n1;2", input
  end

  def test_negative_number_throws_exception
    StringCalculator.add("-1")
  rescue ArgumentError
    assert_equal "input has negative numbers: -1", $!.message
  else
    flunk "Did not raise an exception"
  end

  def test_multiple_negative_numbers_throws_exception
    StringCalculator.add("-1,1,-2")
  rescue ArgumentError
    assert_equal "input has negative numbers: -1, -2", $!.message
  else
    flunk "Did not raise an exception"
  end

  def test_big_numbers_ignored
    assert_equal 2, StringCalculator.add("2,1001")
  end
end

MiniTest::Unit.autorun
