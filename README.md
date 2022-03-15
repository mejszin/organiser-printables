# paper-planner
Scripts for generating paper planner/organiser printable inserts

```bash
bundle install
rake example
```

```ruby
task :example do
    insert = Insert.new(FILOFAX_PERSONAL)
    insert.outlines
    insert.logo("./images/logo.png")
    insert.ratio_rows([2] + [1] * 12)
    insert.columns(4)
    insert.image("./images/rocket.png", 30, 40, 40)
    insert.save_to_file("./example.pdf")
end
```