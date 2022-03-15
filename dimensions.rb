dim_file = File.open('./dimensions.json')
dim_data = JSON.load(dim_file)
dim_file.close

Dimension = Struct.new(:width, :height)

class Dimension
    attr_reader :width, :height

    def initialize(width, height)
        @width, @height = width, height
    end

    def portrait
        Dimension.new([@width, @height].min, [@width, @height].max)
    end
    
    def landscape        
        Dimension.new([@width, @height].max, [@width, @height].min)
    end

    def mm
        return [@width.mm, @height.mm]
    end
end

A4 = Dimension.new(*dim_data["a4"].values)
POCKET = Dimension.new(*dim_data["pocket"].values)
PERSONAL = Dimension.new(*dim_data["personal"].values)
STANDARD = Dimension.new(*dim_data["standard"].values)
FILOFAX_PERSONAL = PERSONAL

hole_file = File.open('./holes.json')
hole_data = JSON.load(hole_file)
hole_file.close

class Holes
    attr_reader :width, :inside, :positions

    def initialize(width, inside, positions)
        @width, @inside, @positions = width, inside, positions
    end
end

PERSONAL_HOLES = Holes.new(*hole_data["personal"].values)