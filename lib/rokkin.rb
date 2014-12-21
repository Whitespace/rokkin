require 'fileutils'

class RokkinError < StandardError; end

class Rokkin
  # Copies assets from lib/assets to path
  def self.containerize(path, options={:force => false})
    bin_path    = File.expand_path(File.dirname(__FILE__))
    asset_path  = File.join(bin_path, "..", "lib", "assets")
    assets      = Dir.entries(asset_path) - ['.', '..']

    asset_list = assets.map do |filename|
      File.join(asset_path, filename)
    end

    # Are we going to overwrite an existing file?
    existing_files = assets - (assets - Dir.entries(path))

    if options[:force] || existing_files.empty?
      begin
        FileUtils.cp(asset_list, path, :preserve => true)
      rescue Errno::EACCES => e
        raise RokkinError.new(e.message)
      end
    else
      message = <<-MSG
        Cannot overwrite the following files: #{existing_files}
        Remove files or retry with --force
      MSG
      raise RokkinError.new(RokkinHelper.strip_heredoc(message))
    end
  end
end

class RokkinHelper
  # Modified from http://api.rubyonrails.org/classes/String.html#method-i-strip_heredoc
  # which linked to https://github.com/rails/rails/blob/b422cda2ebfff4032f4c18271e96ad329c413dcc/activesupport/lib/active_support/core_ext/string/strip.rb#L22
  # File activesupport/lib/active_support/core_ext/string/strip.rb, line 22
  def self.strip_heredoc(heredoc)
    indent = heredoc.scan(/^[ \t]*(?=\S)/).min.length || 0
    heredoc.gsub(/^[ \t]{#{indent}}/, '')
  end
end
