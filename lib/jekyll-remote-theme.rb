# frozen_string_literal: true

require "jekyll"
require "fileutils"
require "tempfile"
require "addressable"
require "net/http"
require "zip"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module Jekyll
  module RemoteTheme
    class DownloadError < StandardError; end

    autoload :Downloader,  "jekyll-remote-theme/downloader"
    autoload :MockGemspec, "jekyll-remote-theme/mock_gemspec"
    autoload :Munger,      "jekyll-remote-theme/munger"
    autoload :Theme,       "jekyll-remote-theme/theme"
    autoload :VERSION,     "jekyll-remote-theme/version"

    CONFIG_KEY               = "remote_theme".freeze
    CONFIG_CACHE_ENABLED_KEY = "remote_theme_cache_enabled".freeze
    CONFIG_CACHE_DIR_KEY     = "remote_theme_cache_dir".freeze
    DEFAULT_CACHE_DIR        = "~/.jekyll-remote-theme-cache".freeze
    LOG_KEY                  = "Remote Theme:".freeze
    TEMP_PREFIX              = "jekyll-remote-theme-".freeze

    def self.init(site)
      Munger.new(site).munge!
    end
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  Jekyll::RemoteTheme.init(site)
end
