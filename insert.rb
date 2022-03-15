
class Insert
    def initialize(dimensions = PERSONAL, double = true)
        @dimensions, @double = dimensions, double
        @pdf = Prawn::Document.new(:page_size => A4.landscape.mm, :margin => 0)
        @print_margin = 20.mm
        @hole_clearing = 11.mm
        @double_spacing = 20.mm
    end

    def top
        return A4.landscape.height.mm - @print_margin
    end

    def left(with_clearing = true)
        return @print_margin + (with_clearing ? @hole_clearing : 0)
    end

    def double_left(with_clearing = true)
        return left(with_clearing) + width(false) + @double_spacing
    end

    def width(with_clearing = true)
        return @dimensions.width.mm - (with_clearing ? @hole_clearing : 0)
    end

    def height
        return @dimensions.height.mm
    end
    
    def draw_outlines
        @pdf.stroke do
            @pdf.line_width = (0.1).mm
            x, y = left(false), top
            @pdf.rectangle([x, y], *@dimensions.mm)
            x = double_left(false)
            @pdf.rectangle([x, y], *@dimensions.mm) if @double
        end
    end

    def columns(count)
        col_width = width / count
        @pdf.stroke do
            @pdf.line_width = (0.1).mm
            for column in (0...count) do
                x, y = left + (column * col_width), top
                @pdf.rectangle([x, y], col_width, height)
                x = double_left + (column * col_width)
                @pdf.rectangle([x, y], col_width, height) if @double
            end
        end
    end

    def rows(count, double_header = false)
        row_height = height / count
        @pdf.stroke do
            for row in (0...count) do
                unless double_header && row == 1
                    x, y = left, top - (row * row_height)
                    height = row_height * ((double_header && row == 0) ? 2 : 1)
                    @pdf.rectangle([x, y], width, height)
                    x = double_left
                    @pdf.rectangle([x, y], width, height) if @double
                end
            end
        end
    end

    def grid(column_count, row_count, double_header = false)
        columns(column_count)
        rows(row_count, double_header)
    end

    def save_to_file(file_name = DEFAULT_FILE_NAME)
        begin
            @pdf.render_file(file_name)
            puts "** Saved file as '#{file_name}'"
            `start #{file_name}`
        rescue
            puts "** Could not save file"
        end
    end
end