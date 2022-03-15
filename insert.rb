class Insert
    def initialize(dimensions = PERSONAL, double = true)
        @dimensions, @double = dimensions, double
        @pdf = Prawn::Document.new(:page_size => A4.landscape.mm, :margin => 0)
        @print_margin = 20.mm
        @hole_margin = 11.mm
        @double_spacing = 20.mm
    end

    def watermark(path)
        unless File.file?(path)
            puts "** Can't find watermark image #{path}"
            return
        end
        image_w, image_h = FastImage.size(path)
        h = @hole_margin - 6.mm
        w = h * (image_w.to_f / image_h.to_f)
        puts "** Watermark image: #{image_w} x #{image_h}px"
        puts "** Scaled image: #{w.floor} x #{h.floor}mm"
        x, y = left(false) + 3.mm, (top - w) - (height - w) / 2
        @pdf.rotate(90, :origin => [x, y]) do
            @pdf.image path, :at => [x, y], :width => w, :height => h
          # @pdf.rectangle([x, y], h, -w)
        end
        if @double
            x = double_left(false) + 3.mm
            @pdf.rotate(90, :origin => [x, y]) do
                @pdf.image path, :at => [x, y], :width => w, :height => h
            end
        end
    end

    def top
        return A4.landscape.height.mm - @print_margin
    end

    def left(with_clearing = true)
        return @print_margin + (with_clearing ? @hole_margin : 0)
    end

    def double_left(with_clearing = true)
        return left(with_clearing) + width(false) + @double_spacing
    end

    def width(with_clearing = true)
        return @dimensions.width.mm - (with_clearing ? @hole_margin : 0)
    end

    def height
        return @dimensions.height.mm
    end
    
    def outlines
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
            @pdf.line_width = (0.1).mm
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
            @pdf.line_width = (0.1).mm
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