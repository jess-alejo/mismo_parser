# frozen_string_literal: true

require 'yaml'

module MismoParser
  class Base
    attr_reader :attributes, :raw_data

    def self.component_name
      snake_case(name).split('::').pop
    end

    def self.columns
      file = File.join(MismoParser.root, 'lib', 'mismo_parser', 'structure', "#{component_name}.yml")
      schema = YAML.load_file(file)
      schema[component_name].transform_keys(&:to_sym)
    end

    def self.inherited(base)
      base.class_eval do
        columns.each do |name, options|
          parent_container = component_name.upcase
          define_method(name) do
            elements = @raw_data[parent_container]
            @attributes[name] = elements[options['xpath']]
          end
        end
      end

      super
    end

    def self.snake_case(str)
      # gsub(/::/, '/').
      str.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
         .gsub(/([a-z\d])([A-Z])/, '\1_\2')
         .tr('-', '_')
         .gsub(/\s/, '_')
         .gsub(/__+/, '_')
         .downcase
    end

    def initialize(raw_data)
      @raw_data = raw_data
      @attributes = {}
    end
  end
end
