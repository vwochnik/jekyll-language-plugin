# Jekyll Language Plugin [![Gem Version](https://badge.fury.io/rb/jekyll-language-plugin.png)](http://badge.fury.io/rb/jekyll-language-plugin)

> Jekyll 3.0-compatible multi-language plugin for posts, pages and includes

Jekyll Language Plugin is an internationalization plugin for [Jekyll][jekyll]. It diversifies pages, posts and includes that have been optimized for the use with this plugin into different languages which are organized into subdirectories named after the language name.

This plugin has been developed with user-simplicity in mind. It does not require a complex setup process unlike some other internationalization plugins.

## Features

* Translates pages and posts into multiple languages
* Supports all template languages that your Liquid pipeline supports.
* Uses liquid tags in your HTML for including translated strings and language-specific includes.
* Supports localized dates via liquid filter
* Works with `jekyll serve --watch`
* Supports includes translated into multiple languages

## Installation

This plugin is available as a [RubyGem][ruby-gem].

Add this line to your application's `Gemfile`:

```
gem 'jekyll-language-plugin'
```

And then execute the `bundle` command to install the gem.

Alternatively, you can also manually install the gem using the following command:

```
$ gem install jekyll-language-plugin`
```

After the plugin has been installed successfully, add the following lines to your `_config.yml` in order to tell Jekyll to use the plugin:

```
gems:
- jekyll-language-plugin
```

## Configuration

Two additional configuration keys must be present in your `_config.yml` in order for the plugin to work properly:

```
language_data: data.lang.%%
language_includes_dir: _i18n
```

The first key, `language_data`, tells the plugin where it can find the translation data used by the liquid tag. `%%` is a placeholder for the language name. So, if the language is `en`, the plugin will look into `data.lang.en`. It is entirely up to you how you are structuring your Jekyll data. You can have a file `lang.yml` inside your `_data` directory or you can have a `lang` subdirectory inside your `_data` directory containing `en.yml` or `en.json`.

## Usage

Every page or post, that needs to be translated must either have a `language` key or a `languages` array inside its YAML front-matter. Additionally, it may also have an `subset` key which tells the plugin to traverse one step further into the language data. So for example, if `subset` is `home` and the `language_data` configuration setting is `data.lang.%%` and the language is `en`, the plugin will look into `data.lang.en.home` for the translation keys used by the liquid tag. Of course, only pages and layouts can use the translation liquid tag but layouts used by posts can therefore benefit from an `subset`.

### Example

This is a page optimized for the language plugin, `home.html`:

```
---
layout: default
languages:
- en
- de
subset: home
---
<h1>{% t title %}</h1>
<p>{% t description %}</p>
```

`t` is the translation tag. In this case, it will look for `data.lang.en.home.title` and `data.lang.en.home.description` for the English language or `data.lang.de.home.title` and `data.lang.de.home.description` for the German language.

To have more of a structure for larger projects, languages are divided into subdirectories. For the English language, the data file `_data/lang/en.yml` will look similar to this:

```
---
home:
  title: My example home page
  description: This is my example home page powered by the Jekyll language plugin.
```

And respectively, the German language data file, `_data/lang/de.yml` looks similar to this:

```
---
home:
  title: Meine Beispielhomepage
  description: Dies ist meine Beispielhomepage getrieben vom Jekyll-Sprachplugin.
```

Create a new file `_layouts/default.html` which will contain the default layout:

```
<!DOCTYPE html>
<html>
  <head{% if page.language %} lang="{{ page.language }}"{% endif %}>
    <meta charset="utf-8">
    <title>{% t title %} | {{ site.title }}</title>
  </head>
<body>
  {{ content }}
  <p><small>{% t footnote %} | <a href="{{ site.baseurl }}/en/" title="English">en</a> | <a href="{{ site.baseurl }}/de/" title="German">de</a></small></p>
</body>
</html>
```

As a side note, if a `subset` is given and the translation liquid tag can not find a key within the given subset of the specified language, it will perform another lookup without the given subset.

So if `footnote` is common to all pages and posts, it can be placed within the root of each language file. For the English language, add the following to `_data/lang/en.yml`:

```
footnote: Copyright (c) Example home page 2015. All rights reserved.
```

For the German language, add the following line to `_data/lang/de.yml`:

```
footnote: Copyright (c) Beispielhomepage. Alle Rechte vorbehalten.
```

If you now run `jekyll build`, you will obtain two separate `home.html` files in your `_site` directory within the `en` and `de` subdirectories, respectively.

### Posts

Similar to pages, posts can also have the `languages` or `language` keys as well as the `subset` key in its YAML front-matter. You can use all supported liquid tags and filters to translate posts but you can also create multiple posts, one for each language.

It is recommended not to make excessive use of the liquid tags in posts but instead create a post for each translation.

## Liquid tags

Currently, there are two liquid tags provided by this plugin.

### Translation Liquid tag

The `t` liquid tag provides a convenient way of accessing language-specific translations from the language data referred to in the configuration file.

If a `subset` is given by the page's or post's front-matter, `t` will look into the given `subset` of the language specified. Only if the key cannot be found there, it will perform another lookup without traversing into the given subset. This can be useful for common translations like a copyright notice. The key can also be a dot-notation of cascaded keys which are traversed upon lookup.

*Example*: `{% t homepage_welcome %}` or `{% t homepage.welcome %}`

### Language-Specific Include Tag

The `tinclude` liquid tag works just like the Jekyll-standard `include` tag. But unlike `include`, `tinclude` will not look into the `_includes` directory. Instead it will look into the directory specified by the `language_includes_dir` configuration setting, here `_i18n`. Then it travels one subdirectory down for the language name. If you `{% tinclude lorem.txt %}`, `tinclude` will look for the file in `_i18n/en/lorem.txt` if the language is English.

*Example*: `{% tinclude imprint.html %}`

### Language-Specific Date Filter

The `tdate` liquid filter provides localized date-formatting using the day and month names specified in the language data for each language. Note that if you are using this filter, a `date` key must be present for every supported language.

The `tdate` filter takes one argument, the date format language key. A lookup is performed just like the `t` tag does.

The following excerpt shows the english date translation:

```
date:
  abbr_daynames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  daynames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  abbr_monthnames: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  monthnames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
```

*Example*: `{{ post.date | tdate: 'post_date_format' }}`

# Example Site

This repository contains a ready-to-use example site using this plugin in the `example` subdirectory. Check it out and run `bundle install` followed by `bundle exec jekyll build` to build the site.

# Contribute

Fork this repository, make your changes and then issue a pull request. If you find bugs or have new ideas that you do not want to implement yourself, file an issue.

# Copyright

Copyright (c) Vincent Wochnik 2015.
License: MIT

[jekyll]: https://github.com/mojombo/jekyll
[ruby-gem]: https://rubygems.org/gems/jekyll-language-plugin
