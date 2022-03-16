require 'rubygems'
require 'bundler'
Bundler.setup(:default, :ci)

require 'json'
require 'fastimage'
require 'prawn'
require 'prawn/measurement_extensions'

def prawn_clr(clr)
    return clr[1, 6]
end

require_relative './dimensions.rb'
require_relative './insert.rb'
require_relative './grid.rb'
require_relative './logo.rb'
require_relative './image_grid.rb'