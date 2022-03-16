class Insert
    def logo(path)
        unless File.file?(path)
            puts "** Can't find watermark image #{path}"
            return
        end
        image_w, image_h = FastImage.size(path)
        h = @hole_margin - 6.mm
        w = h * (image_w.to_f / image_h.to_f)
        puts "** Original image: #{image_w} x #{image_h}px"
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
end