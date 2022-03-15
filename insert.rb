
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

    def ratio_columns(ratios)
        col_widths = ratios.map { |ratio| ratio * (width / ratios.sum) }
        @pdf.stroke do
            col_left = 0
            for col in (0...ratios.length) do
                x, y = left + col_left, top
                @pdf.rectangle([x, y], col_widths[col], height)
                x = double_left + col_left
                @pdf.rectangle([x, y], col_widths[col], height) if @double
                col_left += col_widths[col]
            end
        end
    end

    def ratio_rows(ratios)
        row_heights = ratios.map { |ratio| ratio * (height / ratios.sum) }
        @pdf.stroke do
            row_top = 0
            for row in (0...ratios.length) do
                x, y = left, top - row_top
                @pdf.rectangle([x, y], width, row_heights[row])
                x = double_left
                @pdf.rectangle([x, y], width, row_heights[row]) if @double
                row_top += row_heights[row]
            end
        end
    end

    
    def columns(count)
        ratio_columns(Array.new(count) { 1 })
    end

    def rows(count)
        ratio_rows(Array.new(count) { 1 })
    end

    def grid(column_count, row_count)
        columns(column_count)
        rows(row_count)
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