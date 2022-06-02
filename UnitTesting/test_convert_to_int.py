# Import the pytest package
import pytest

# Import the function convert_to_int()
from preprocessing_helpers import convert_to_int

# Complete the unit test name by adding a prefix
def test_on_string_with_one_comma():
  test_argument = "2,081"
  expected = 2081
  actual = convert_to_int(test_argument)
  message = "convert_to_int('2,081') should return the int 2081, but it actually returned {0}".format(actual)
  assert actual == expected, message