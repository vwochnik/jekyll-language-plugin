require 'yaml'
require 'rails-i18n'
require 'i18n-iso639matrix'
require 'psych'

def gem_files(gem, glob)
  gem_root = Gem.loaded_specs[gem].full_gem_path
  Dir[File.join(gem_root, glob)]
end

rails_i18n = gem_files('rails-i18n', 'rails/locale/*.yml').inject({}) do |rails_i18n, file|
  key = File.basename(file, '.yml')
  source = YAML.load_file(file)
  next rails_i18n if key !~ /\A[a-z]{2}\z/ || !source.has_key?(key) || source[key]['date'].nil?

  # extract date object
  date = source[key]['date']
  date.delete_if { |k, _| k !~ /\A(?:abbr_day_names|abbr_month_names|day_names|month_names)\z/ }
  date = Hash[date.map { |k, v| [k.sub(/_names\Z/, 'names'), v] }]
  date['abbr_monthnames'].shift
  date['monthnames'].shift

  rails_i18n.merge!({
    key => { 'date' => date }
  })
end

matrix = gem_files('i18n-iso639matrix', 'config/locales/*.yml').inject({}) do |matrix, file|
  key = File.basename(file, '.yml')
  source = YAML.load_file(file)
  next matrix if key !~ /\A[a-z]{2}\z/ || !source.has_key?(key)
  matrix.merge!({key => source[key]})
end

# intersection of rails-i18n and i18n-iso639matrix translations
codes = rails_i18n.keys & matrix.keys

# merge all imported data
data = codes.inject(Hash.new) do |data, code|
  lang = codes.inject(Hash.new) do |lang, code2|
    translation = matrix[code][code2].split(/[,\/]/)[0].strip
    lang.merge!({ code2 => translation})
  end

  data.merge!({
    code => {
      'date' => rails_i18n[code],
      'lang' => lang
    }
  })
end

Dir.mkdir('lang') unless File.directory?('lang')
codes.each do |code|
  obj = { code => data[code] }

  visitor = Psych::Visitors::YAMLTree.new
  visitor << obj
  ast = visitor.tree

  ast.grep(Psych::Nodes::Sequence).each do |node|
    node.style  = Psych::Nodes::Sequence::FLOW
  end

  File.open("lang/#{code}.yml", 'w') {|f| f.write ast.yaml }
end
