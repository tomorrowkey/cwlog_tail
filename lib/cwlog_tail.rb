require 'cwlog_tail/version'
require 'cwlog_tail/cw_client'
require 'cwlog_tail/options'
require 'peco_selector'

module CwlogTail
  client = CwClient.new
  options = Options.new(ARGV)

  log_group_name = options.log_group || PecoSelector.select_from(client.log_group_names).first
  exit 0 unless log_group_name

  log_stream_name = options.log_stream || PecoSelector.select_from(client.log_streams(log_group_name, options.page_count).map{|log_stream|
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
