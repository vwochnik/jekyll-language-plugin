# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class URL
    # optimized version by Jordon Bedwell
    def sanitize_url(str)
      "/" + str.gsub(/\/{2,}/, "/").gsub(%r!\.+\/|\A/+!, "")
    end
  end
end
