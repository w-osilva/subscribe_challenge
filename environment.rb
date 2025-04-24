# frozen_string_literal: true

require_relative 'boot'

require 'zeitwerk'
loader = Zeitwerk::Loader.new
# load libraries
loader.push_dir('lib')
loader.collapse('lib/cli')
loader.collapse('lib/models')
loader.collapse('lib/services')
loader.setup
