require 'cwlog_tail/version'
require 'cwlog_tail/cw_client'
require 'peco_selector'

module CwlogTail
  def self.follow?
    ARGV.member?('-f')
  end

  def self.lines
    idx = ARGV.index('-l') || ARGV.index('--lines')
    if idx.nil?
      nil
    else
      ARGV[idx + 1].to_i
    end
  end

  def self.options
    { follow: follow?,
      lines: lines,
    }
  end

  client = CwClient.new

  log_group_name = PecoSelector.select_from(client.log_group_names).first
  exit 0 unless log_group_name

  log_stream_name = PecoSelector.select_from(client.log_streams(log_group_name).map{|log_stream|
    ["#{Time.at(log_stream.last_event_timestamp / 1000)} #{log_stream.log_stream_name}", log_stream]
  }).first&.log_stream_name
  exit 0 unless log_stream_name

  begin
    client.tail_stream(log_group_name, log_stream_name, options) do |event|
      puts "[#{Time.at(event.timestamp / 1000)}] #{event.message}"
    end
  rescue Interrupt
    puts ''
  end
end
