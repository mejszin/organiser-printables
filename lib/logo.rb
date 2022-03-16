class Insert
    def image_at(path, x, y, w, h)
        if File.extname(path) == ".svg"
            file = File.open(path)
            @pdf.svg(file, :at => [x, y], :width => w, :height => h)
        else
            @pdf.image(path, :at => [x, y], :width => w, :height => h)
        end
      # @pdf.stroke_rectangle([x, y], w, h)
    end

    def logo(path, image_w = 0, image_h = 0)
        unless File.file?(path)
            puts "** Can't find watermark image #{path}"
            return
        end
        image_w, image_h = FastImage.size(path) if image_w == 0 || image_h == 0
        h = @hole_margin - 6.mm
        w = h * (image_w.to_f / image_h.to_f)
        puts "** Original image: #{image_w} x #{image_h}px"
        puts "** Scaled image: #{w.floor} x #{h.floor}mm"
        puts "** Image extension: #{File.extname(path)}"
        x, y = left(false) + 3.mm, (top - w) - (height - w) / 2
        @pdf.rotate(90, :origin => [x, y]) do
            image_at(path, x, y, w, h)
        end
        if @double
            x = double_left(false) + 3.mm
            @pdf.rotate(90, :origin => [x, y]) do
                image_at(path, x, y, w, h)
            end
        end
    end
end