class Insert
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
        ratio_columns([1] * count)
    end

    def rows(count)
        ratio_rows([1] * count)
    end

    def grid(column_count, row_count)
        columns(column_count)
        rows(row_count)
    end
end