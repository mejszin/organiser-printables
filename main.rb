require 'rubygems'
require 'bundler'
Bundler.setup(:default, :ci)

require 'json'
require 'fastimage'
require 'prawn'
require 'prawn/measurement_extensions'

DEFAULT_FILE_NAME = './untitled.pdf'

require_relative './dimensions.rb'
require_relative './insert.rb'

insert = Insert.new(PERSONAL)
insert.outlines
insert.watermark("./watermark.png")
insert.ratio_rows([2] + [1] * 12)
insert.columns(4)
insert.save_to_file