module JekyllLanguagePlugin
  module LiquidContext
    def self.get_language_data(context, keys = nil)
      site = context.registers[:site]
      language_data = site.config['language_data'].to_s || 'data.lang.%%'

      page_language = context.registers[:page]['language']
      return nil if page_language.to_s.empty?

      keys2 = language_data.gsub("%%", page_language).split('.')
      language_data = site.send(keys2.shift)
      language_data = self.traverse_hash(language_data, keys2)
      raise JekyllLanguagePlugin::PluginError.new('Invalid language data configuration.') if language_data.nil?

      return language_data if keys.to_s.empty? # can also return nil

      language_data = self.traverse_hash(language_data, keys)
      raise JekyllLanguagePlugin::PluginError.new("Language subset #{keys.to_s} not found.") if language_data.nil?
      language_data
    end

    def self.get_language_string(context, key)
      data = self.get_language_data(context)
      return "" if data.nil?

      page_alias = context.registers[:page]['alias']
      if (!page_alias.to_s.empty? &&
          !(str = traverse_hash(traverse_hash(data, page_alias), key)).to_s.empty?) ||
         !(str = traverse_hash(data, key)).to_s.empty?
        return str
      end

      raise JekyllLanguagePlugin::PluginError.new("Language string #{key} not found.")
    end

    def self.traverse_hash(hash, keys)
      return nil if hash.nil? || keys.to_s.empty?
      keys = keys.split('.') if keys.is_a?(String)

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
  end
end
