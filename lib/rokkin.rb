require 'fileutils'

class Rokkin
  def self.containerize(path)
    bin_path = File.expand_path(File.dirname(__FILE__))
    lib_path = File.join(bin_path, "..", "lib")

    %w[.env fig.yml Dockerfile Procfile].each do |filename|
      FileUtils.cp(File.join(lib_path, filename), path)
    end
  end
end
