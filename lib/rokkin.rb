require 'fileutils'
require 'pathname'

class Rokkin
  def self.slag_off
    puts "ROKKIN!!!"
  end

  def self.containerize(path=File.expand_path(Pathname.new('.')))
    %w[.env fig.yml Dockerfile Procfile].each do |filename|
      FileUtils.cp(
        File.join(File.expand_path(File.dirname(__FILE__)), "..", "lib", filename),
        path)
    end
  end
end
