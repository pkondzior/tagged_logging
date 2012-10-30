require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/logger'
require 'logger'
require 'tagged_logging/version'

module TaggedLogging
  module Formatter # :nodoc:
                   # This method is invoked when a log event occurs.
    def call(severity, timestamp, progname, msg)
      super(severity, timestamp, progname, "#{tags_text}#{msg}")
    end

    def tagged(*tags)
      new_tags = push_tags(*tags)
      yield self
    ensure
      pop_tags(new_tags.size)
    end

    def push_tags(*tags)
      tags.flatten.reject(&:blank?).tap do |new_tags|
        current_tags.concat new_tags
      end
    end

    def pop_tags(size = 1)
      current_tags.pop size
    end

    def clear_tags!
      current_tags.clear
    end

    def current_tags
      Thread.current[:tagged_logging_tags] ||= []
    end

    private
    def tags_text
      tags = current_tags
      if tags.any?
        tags.collect { |tag| "[#{tag}] " }.join
      end
    end
  end

  def self.new(logger)
    # Ensure we set a default formatter so we aren't extending nil!
    logger.formatter ||= ActiveSupport::Logger::SimpleFormatter.new
    logger.formatter.extend Formatter
    logger.extend(self)
  end

  delegate :push_tags, :pop_tags, :clear_tags!, to: :formatter

  def tagged(*tags)
    formatter.tagged(*tags) { yield self }
  end

  def flush
    clear_tags!
    super if defined?(super)
  end
end