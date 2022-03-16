DEFAULT_FILE_NAME = './untitled.pdf'

class Insert
    attr_reader :dimensions, :hole_margin

    def initialize(dimensions = FILOFAX_PERSONAL, double = true)
        @dimensions, @double = dimensions, double
        @pdf = Prawn::Document.new(:page_size => A4.landscape.mm, :margin => 0)
        @print_margin = 20.mm
        @hole_margin = 11.mm
        @double_spacing = 20.mm
    end

    def image(path, l, t, w, h = nil)
        unless File.file?(path)
            puts "** Can't find image #{path}"
            return
        end
        if h == nil # Auto-scale
            image_w, image_h = FastImage.size(path)
            h = w * (image_h.to_f / image_w.to_f)
            puts "** Original image: #{image_w} x #{image_h}px"
            puts "** Scaled image: #{w.floor} x #{h.floor}mm"
        end
        image_at(path, left + l, top - t, w, h)
        image_at(path, double_left + l, top - t, w, h) if @double
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

    def outlines(hole_data = nil)
        @pdf.stroke do
            @pdf.line_width = (0.1).mm
            x, y = left(false), top
            @pdf.rectangle([x, y], *@dimensions.mm)
            x = double_left(false)
            @pdf.rectangle([x, y], *@dimensions.mm) if @double
        end
        holes(hole_data) unless hole_data == nil
    end

    def holes(data)
        for position in data.positions do
            @pdf.stroke do
                @pdf.line_width = (0.1).mm
                x, y = left(false) + data.inside.mm, top - position.mm
                @pdf.circle([x, y], data.width.to_f.mm / 2)
                x = double_left(false) + data.inside.mm
                @pdf.circle([x, y], data.width.to_f.mm / 2) if @double
            end
        end
    end

    def text(caption, l, t, w, h, size = 32, clr = nil)
        @pdf.fill_color = clr == nil ? prawn_clr("#000000") : prawn_clr(clr)
        args = { 
            :at => [left + l.mm, top - t.mm], 
            :width => w.mm, :height => h.mm, 
            :style => :normal, :overflow => :shrink_to_fit,
            :valign => :center, :align => :center,
            :size => size, :min_font_size => 4,
            :inline_format => true
        }
        @pdf.text_box(caption, args)
        args[:at] = [double_left + l.mm, top - t.mm]
        @pdf.text_box(caption, args) if @double
    end

    def box(l, t, w, h, clr = nil)
        @pdf.fill_color = clr == nil ? prawn_clr("#FFFFFF") : prawn_clr(clr)
        @pdf.line_width = (0.1).mm
        x, y = left + l.mm, top - t.mm
        unless clr == nil
            @pdf.fill_and_stroke_rectangle([x, y], w.mm, h.mm)
        else
            @pdf.stroke_rectangle([x, y], w.mm, h.mm)
        end
        if @double
            x = double_left + l.mm
            unless clr == nil
                @pdf.fill_and_stroke_rectangle([x, y], w.mm, h.mm)
            else
                @pdf.stroke_rectangle([x, y], w.mm, h.mm)
            end
        end
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