require 'test_helper'

class DefaultTest < Test::Unit::TestCase

  def setup

  end

  def teardown
  end

  def test_the_truth
    line = "#Fields: date time s-sitename s-computername s-ip cs-method cs-uri-stem cs-uri-query s-port cs-username c-ip cs-version cs(User-Agent) cs(Referer) cs-host sc-status sc-substatus sc-win32-status sc-bytes cs-bytes time-taken"
    ifa = IISFieldAnalyzer.new(line[9..-1].split(" "))
    puts ifa.grok_section
    assert true
  end
end
