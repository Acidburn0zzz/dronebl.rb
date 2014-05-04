#!/usr/bin/env ruby
# copyright Rylee Fowler 2014
# see LICENSE for more details

require 'nokogiri'
require 'httparty'
module DroneBL
  include HTTParty
  format :xml
  base_uri 'http://dronebl.org'
  TYPES = {"1"=>"Testing class.",
           "2"=>"Sample data",
           "3"=>"IRC spam drone",
           "5"=>"Bottler (experimental)",
           "6"=>"Unknown worm or spambot",
           "7"=>"DDoS drone",
           "8"=>"Open SOCKS proxy",
           "9"=>"Open HTTP proxy",
           "10"=>"Proxychain",
           "11"=>"Web Page Proxy",
           "13"=>"Automated dictionary attacks",
           "14"=>"Open WINGATE proxy",
           "15"=>"Compromised router / gateway",
           "16"=>"Autorooting worms",
           "17"=>"Automatically determined botnet IP",
           "255"=>"Uncategorized threat class"}
  class << self
    attr_accessor :key
    def parse_response xml
      # This giant mess of hax is needed because the DroneBL response to queries
      # is encased in CDATA for whatever reason.
      resp = Nokogiri::XML(xml).at("response")
      if resp['type'].downcase == 'error'
        abort "call failed: '#{resp.css('message').text}' data: '#{resp.css('data').text}'"
      end
      Nokogiri::XML("<?xml version='1.0'>\n<results>#{resp.text}</results>").css("result").map(&:to_h) # thanks to jhass in #ruby on freenode
    end

    def gen_lookup_query ips, archived
      <<EOF
<?xml version='1.0'?>
<request key='#{key}'>
      #{ips.map { |ip| "<lookup ip='#{ip}' listed='#{archived ? 2 : 1}'>"}.join("\n")}
</request>
EOF
    end
    def gen_add_query ips, type, comment
      "<?xml version='1.0'?>
<request key='#{key}'>
      #{ips.map { |ip| "<add ip='#{ip}' type='#{type}'#{ " comment='#{comment}'" unless comment.empty?}>"}.join("\n")}
</request>"
    end

    def lookup ips, archived=false
      query = gen_lookup_query ips, archived
      parse_response post('/RPC2', {:body => query }).body
    end

    def add ips, type, comment=''
      query = gen_add_query ips, type, comment
      parse_response post('/RPC2', {:body => query }).body
    end

  end
end
