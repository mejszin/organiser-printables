require 'rubygems'
require 'bundler'
Bundler.setup(:default, :ci)

require 'json'
require 'prawn'
require 'prawn/measurement_extensions'

DEFAULT_FILE_NAME = './untitled.pdf'

require_relative './dimensions.rb'
require_relative './insert.rb'

insert = Insert.new(FILOFAX_PERSONAL)
insert.draw_outlines
# insert.grid(4, 12, true)
insert.ratio_columns([1, 2, 3, 1, 2, 3])
insert.rows(4)
insert.save_to_file