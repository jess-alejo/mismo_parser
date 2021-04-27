# frozen_string_literal: true

require_relative 'mismo_parser/version'

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup
loader.push_dir(File.join(__dir__, 'mismo_parser', 'component'))

module MismoParser
  def self.root
    File.dirname __dir__
  end
end
