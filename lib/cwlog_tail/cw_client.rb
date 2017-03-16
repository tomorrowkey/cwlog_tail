require 'aws-sdk'

module CwlogTail
  class CwClient
    DEFAULT_LINES = 100

    def client
      @cloudwatch ||= Aws::CloudWatchLogs::Client.new
    end

    def log_groups
      client.describe_log_groups.log_groups
    end

    def log_group_names
      log_groups.map(&:log_group_name)
    end

    def log_streams(log_group_name, page_count)
      next_token = nil
      @log_streams ||= page_count.times.each.with_object([]) { |_, results|
        log_streams = client.describe_log_streams(
          log_group_name: log_group_name,
          order_by: :LastEventTime,
          descending: true,
          next_token: next_token)
        results << log_streams.log_streams
        next_token = log_streams.next_token
      }.flatten
    end

    def tail_stream(log_group_name, log_stream_name, options)
      last_token = nil
      loop do
        log_options = {
          log_group_name: log_group_name,
          log_stream_name: log_stream_name,
          next_token: last_token
        }
        if options.lines.nil?
          log_options[:start_from_head] = true
          log_options[:limit] = DEFAULT_LINES
        else
          log_options[:start_from_head] = false
          log_options[:limit] = options.lines
        end
        pages = client.get_log_events(log_options)
        pages.events.each { |event| yield(event) }

        if last_token == pages.next_forward_token
          if options.follow?
            sleep options.interval
          else
            break
          end
        end
        last_token = pages.next_forward_token
      end
    end
  end
end
