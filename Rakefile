require './lib/include.rb'

task :example do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines
    insert.logo("./logo.png")
    insert.ratio_rows([2] + [1] * 12)
    insert.columns(4)
    insert.save_to_file("./table.pdf")
end