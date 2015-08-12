require 'yaml'

module YourWaifu
  # This is the base of all your waifus.
  # Subclasses MUST implement config_name
  class Base
    attr_reader list

    # The constructor loads the entire list and stores it as a class variable
    # for faster lookups.
    # If you want to force a reload, set `force_reload` to true.
    # @param force_reload [Boolean] Force a reload of the list.
    def initialize(force_reload = false)
      @@list ||= []
      @@list = YAML.load_file(File.join(LIST_PATH, "#{config_name}.yml")) if @@list.empty? || force_reload
    end

    # Returns a waifu entry.
    # @return [Hash] a hash with the string keys `'name'`, `'series'`, and `'filetype'`
    def sample
      @@list.sample
    end

    protected

    # This method returns the unique part of the file name of the list
    # containing all waifus.  For instance, if the list is located at
    # `../lists/husbando.yml`, this method returns `husbando`.
    #
    # Subclasses MUST implement this, otherwise a NotImplementedError is
    # thrown.
    # @return [String] A part of the file name
    def config_name
      throw NotImplementedError
    end
  end
end

