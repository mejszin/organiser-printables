require 'rubygems'
require 'bundler'
Bundler.setup(:default, :ci)

require 'json'
require 'fastimage'
require 'prawn'
require 'prawn/measurement_extensions'

require_relative './dimensions.rb'
require_relative './insert.rb'