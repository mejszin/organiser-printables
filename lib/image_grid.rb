class Insert
    def image_grid(path, cols, rows, l = 0, t = 0, w = 0, h = 0)
        w = w == 0 ? width : w.mm
        h = h == 0 ? height : h.mm
        l, t = l.mm, t.mm
        area_w, area_h = w / cols.to_f, h / rows.to_f
        img_w, img_h = FastImage.size(path)
        puts "** Original image: #{img_w} x #{img_h}px"
        if area_w > area_h
            img_w = area_h * (img_w.to_f / img_h.to_f)
            img_h = area_h
        else
            img_h = area_w * (img_h.to_f / img_w.to_f)
            img_w = area_w
        end
        puts "** Scaled image: #{img_w} x #{img_h}mm"
        for c in (0...cols) do
            for r in (0...rows) do
                x, y = left + l + (c * area_w), top - t - (r * area_h)
                xy = [x + (area_w - img_w) / 2, y - (area_h - img_h) / 2]
                args = [path, :at => xy, :width => img_w, :height => img_h]
                @pdf.image(*args)
                if @double
                    x = double_left + l + (c * area_w)
                    xy = [x + (area_w - img_w) / 2, y - (area_h - img_h) / 2]
                    args = [path, :at => xy, :width => img_w, :height => img_h]
                    @pdf.image(*args)
                end
            end
        end
    end
end