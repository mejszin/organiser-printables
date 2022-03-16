class Insert
    def ratio_columns(ratios, l = 0, t = 0, w = 0, h = 0)
        w = w == 0 ? width : w.mm
        h = h == 0 ? height : h.mm
        l, t = l.mm, t.mm
        col_widths = ratios.map { |ratio| ratio * (w.to_f / ratios.sum) }
        @pdf.stroke do
            @pdf.line_width = (0.1).mm
            col_left = 0
            for col in (0...ratios.length) do
                x, y = left + l + col_left, top - t
                @pdf.rectangle([x, y], col_widths[col], h)
                x = double_left + l + col_left
                @pdf.rectangle([x, y], col_widths[col], h) if @double
                col_left += col_widths[col]
            end
        end
    end

    def ratio_rows(ratios, l = 0, t = 0, w = 0, h = 0)
        w = w == 0 ? width : w.mm
        h = h == 0 ? height : h.mm
        l, t = l.mm, t.mm
        row_heights = ratios.map { |ratio| ratio * (h.to_f / ratios.sum) }
        @pdf.stroke do
            @pdf.line_width = (0.1).mm
            row_top = 0
            for row in (0...ratios.length) do
                x, y = left + l, top - t - row_top
                @pdf.rectangle([x, y], w, row_heights[row])
                x = double_left + l
                @pdf.rectangle([x, y], w, row_heights[row]) if @double
                row_top += row_heights[row]
            end
        end
    end

    def columns(count, l = 0, t = 0, w = 0, h = 0)
        ratio_columns([1] * count, l, t, w, h)
    end

    def rows(count, l = 0, t = 0, w = 0, h = 0)
        ratio_rows([1] * count, l, t, w, h)
    end

    def grid(column_count, row_count, l = 0, t = 0, w = 0, h = 0)
        columns(column_count, l, t, w, h)
        rows(row_count, l, t, w, h)
    end
end