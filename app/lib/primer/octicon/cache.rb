# frozen_string_literal: true

module Primer
  module Octicon
    # :nodoc:
    class Cache
      LOOKUP = {} # rubocop:disable Style/MutableConstant
      # Preload the top 20 used icons.
      PRELOADED_ICONS = [:alert, :check, :"chevron-down", :clippy, :clock, :"dot-fill", :info, :"kebab-horizontal", :link, :lock, :mail, :pencil, :plus, :question, :repo, :search, :"shield-lock", :star, :trash, :x].freeze

      class << self
        def get_key(name:, size:, width: nil, height: nil)
          [name, size, width, height].join("_")
        end

        def read(key)
          LOOKUP[key]
        end

        # Cache size limit.
        def limit
          500
        end

        def set(key, value)
          LOOKUP[key] = value

          # Remove first item when the cache is too large.
          LOOKUP.shift if LOOKUP.size > limit
        end

        def clear!
          LOOKUP.clear
        end

        def preload!
          PRELOADED_ICONS.each { |icon| Primer::OcticonComponent.new(icon: icon) }
        end
      end
    end
  end
end
