# Jekyll Language Plugin [![Gem Version](https://badge.fury.io/rb/jekyll-language-plugin.png)](http://badge.fury.io/rb/jekyll-language-plugin)

> Jekyll 3.0-compatible multi-language plugin for posts, pages and includes

<div align="center"><img src="https://raw.githubusercontent.com/vwochnik/jekyll-language-plugin/master/images/jekyll-i18n-logo.png" width="480" height="143" alt="Jekll Language Plugin"></div>

Jekyll Language Plugin is an internationalization plugin for [Jekyll][jekyll]. It diversifies pages, posts and includes that have been optimized for the use with this plugin into different languages which are organized into subdirectories named after the language name.

This plugin has been developed with user-simplicity in mind. It does not require a complex setup process unlike some other internationalization plugins.

## Features

* Translates pages and posts into multiple languages
* Supports all template languages that your Liquid pipeline supports.
* Uses liquid tags in your HTML for including translated strings and language-specific includes.
* Supports localized dates via liquid filter
* Supports localized URLs
* Works with `jekyll serve --watch`
* Supports includes translated into multiple languages
* Includes language and date translations for 82 languages

## Installation

This plugin is available as a [RubyGem][ruby-gem].

Add this line to your application's `Gemfile`:

```
gem 'jekyll-language-plugin'
```

And then execute the `bundle` command to install the gem.

Alternatively, you can also manually install the gem using the following command:

```
$ gem install jekyll-language-plugin
```

After the plugin has been installed successfully, add the following lines to your `_config.yml` in order to tell Jekyll to use the plugin:

```
gems:
- jekyll-language-plugin
```

## Getting Started

The [repository's wiki][wiki] contains detailed information on how to get [started using the plugin][getting-started].

# Example Site

This repository contains a ready-to-use example site using this plugin in the `example` subdirectory. Check it out and run `bundle install` followed by `bundle exec jekyll build` to build the site.

# Contribute

Fork this repository, make your changes and then issue a pull request. If you find bugs or have new ideas that you do not want to implement yourself, file a bug report.

# Copyright

Copyright (c) 2015 Vincent Wochnik.

License: MIT

[jekyll]: https://github.com/mojombo/jekyll
[ruby-gem]: https://rubygems.org/gems/jekyll-language-plugin
[wiki]: //github.com/vwochnik/jekyll-language-plugin/wiki
[getting-started]: //github.com/vwochnik/jekyll-language-plugin/wiki/Getting-Started
