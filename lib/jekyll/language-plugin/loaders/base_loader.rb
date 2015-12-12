module Jekyll
  module LanguagePlugin
    module Loaders
      class BaseLoader
        attr_reader :site, :is_loaded

        def initialize(site)
          @site = site
          @is_loaded = false
        end

        def loaded?
          @is_loaded
        end

        def load
          @is_loaded
        end

        def get(key, language)
          nil
        end

        def traverse_hash(hash, keys)
          for key in keys
            if !hash.is_a?(Hash)
              return hash
            elsif !hash.key?(key)
              return nil
            end
            hash = hash[key]
          end
          hash
        end

        def resolve_dot_notation(keys)
          return keys.split('.') if keys.is_a?(String)
          return [] if !keys.is_a?(Enumerable)

          keys.flat_map do |key|
            resolve_dot_notation(key)
          end
        end
      end
    end
  end
end
