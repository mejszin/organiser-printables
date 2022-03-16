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
    insert.logo("./images/projective.svg")
    insert.image_grid("./images/heart.svg", 8, 15, 0, 15, 80, 150)
    insert.save_to_file("./example.pdf")
end

task :good_bad_ideas do # Good Ideas 良いアイデア Bad Ideas 悪いアイデア
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    width = insert.dimensions.width - 20
    insert.box(4, 5, width, 8, "#AFCBFF")
    insert.text("<i>Good Ideas</i>", 4, 6, width, 6)
    insert.box(4, 94, width, 8, "#FFFFD1")
    insert.text("<i>Bad Ideas</i>", 4, 95, width, 6)
    insert.save_to_file("./example.pdf")
end

task :project_outline do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    insert.logo("./images/projective.png")
    ratio = [1, 1, 4, 4]
    width, height, left = insert.dimensions.width - 18, 6, 2
    for top in [6, 61, 116] do
        insert.box(left, top, width, height)
        insert.box(left, top + height, width, height, "#D0E1F5")
        insert.ratio_columns(ratio, left, top, width, height)
        insert.rows(6, left, top + height * 2, width, height * 6)
        insert.ratio_columns(ratio, left, top + height * 2, width, height * 6)
    end
    insert.save_to_file("./example.pdf")
end

task :cornell do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines(FILOFAX_PERSONAL_HOLES)
    insert.logo("images/projective.svg")
    width, left, top, line, margin = insert.dimensions.width - 18, 2, 6, 5, 4
    insert.grid(2, 1, left, top, width, line)
    insert.grid(3, 1, left, top + line, width, line)
    insert.grid(2, 1, left, top + line * 2 + margin, width, line * 16)
    insert.grid(1, 16, left + width.to_f / 2, top + line * 2 + margin, width.to_f / 2, line * 16)
    insert.box(left, top + line * 18 + margin * 2, width, line * 12.25)
    insert.save_to_file
end