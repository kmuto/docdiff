#!/usr/bin/ruby
require 'test/unit'
require 'document'
require 'nkf'
require 'uconv'

class TC_Document < Test::Unit::TestCase

  def setup()
    #
  end

  def test_codeset()
    doc = Document.new("Foo bar.\nBaz quux.")
    doc.codeset = 'ASCII'
    doc.eol = 'LF'
    expected = 'ASCII'
    assert_equal(expected, doc.codeset)
  end
  def test_eol()
    doc = Document.new("Foo bar.\nBaz quux.")
    doc.codeset = 'ASCII'
    doc.eol = 'LF'
    expected = 'LF'
    assert_equal(expected, doc.eol)
  end

  def teardown()
    #
  end

end