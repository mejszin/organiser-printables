require './lib/include.rb'

task :example do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    insert.logo("./images/logo.png")
    insert.ratio_rows([2] + [1] * 12)
    insert.columns(4)
    insert.image("./images/rocket.png", 30, 40, 40)
    insert.save_to_file("./example.pdf")
end

task :circle_grid do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    insert.image_grid("./images/circle.png", 16, 30, 0, 15, 80, 150)
    insert.save_to_file("./example.pdf")
end

task :heart_grid do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    insert.logo("./images/logo.png")
    insert.image_grid("./images/heart.png", 8, 15, 0, 15, 80, 150)
    insert.save_to_file("./example.pdf")
end

task :good_bad_ideas do
    # Good Ideas 良いアイデア Bad Ideas 悪いアイデア
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    width = insert.dimensions.width - 20
    insert.box(4, 5, width, 8, "#AFCBFF")
    insert.text("<i>Good Ideas</i>", 4, 6, width, 6)
    insert.box(4, 94, width, 8, "#FFFFD1")
    insert.text("<i>Bad Ideas</i>", 4, 95, width, 6)
    insert.save_to_file("./example.pdf")
end