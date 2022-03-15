require './lib/include.rb'

insert = Insert.new(PERSONAL)
insert.outlines
insert.watermark("./watermark.png")
insert.ratio_rows([2] + [1] * 12)
insert.columns(4)
insert.save_to_file