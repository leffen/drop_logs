require 'paxx'
require 'pp'

class IISFieldAnalyzer
  attr_reader :field_map,:src_fields,:mfields

  FIELD_MAP={
    "date" => '%{TIMESTAMP_ISO8601:log_timestamp}',
    "time" => nil,
    "s_sitename" => '%{IPORHOST:server_site}',
    "s_computername" => '(%{WORD:server_name}|-)',
    "s_ip" => '%{IPORHOST:server_ip}',
    "cs_method" => '%{NOTSPACE:method}',
    "cs_uri_stem" => '%{URIPATH:page}',
    "cs_uri_query" => '(?:%{NOTSPACE:querystring}|-)',
    "s_port" => '%{NUMBER:port}',
    "cs_username" => '(%{WORD:username}|-)',
    "c_ip" => '%{IPORHOST:clienthost}',
    "cs_version" => '(?:%{NOTSPACE:protocol_version}|-)',
    "cs_user_agent" => '(?:%{NOTSPACE:useragent}|-)',
    "cs_referer" => '(?:%{NOTSPACE:referer}|-)',
    "cs_host" => '(?:%{NOTSPACE:cs_host}|-)',
    "sc_status" => '%{NUMBER:response}',
    "sc_substatus" => '%{NUMBER:subresponse}',
    "sc_win32_status" => '%{NUMBER:scstatus}',
    "sc_bytes" => '%{NUMBER:bytes_sendt}',
    "cs_bytes" => '%{NUMBER:bytes_received}',
    "time_taken" => '%{NUMBER:time_taken}'
  }

  def initialize(src_fields)
    @src_fields = src_fields
    @fields = process_fields src_fields
    @mfields = map_fields @fields
  end

  def process_fields fields
    fields.map{|field|
      v = field.gsub(/\(/," ")
      v = v.gsub(/\)/," ")
      v = Paxx::NameNormalizer.new(v).as_slug
      v.gsub(/-/,'_')
    }
  end

  def map_fields fields
    fields.map{|field|
      FIELD_MAP[field]
    }.compact
  end

  def grok_line
    @mfields.join(" ")
  end

  def grok_section
    "grok {\n   match => [\"message\",\"#{grok_line}\"]\n} "
  end
end

