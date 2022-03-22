# XlsxtreamRails
Xlsx stream download for rails with template.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "xlsxtream_rails"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install xlsxtream_rails
```

## Controller

Set your instance variables in your controller and configure the response if needed:

```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all
    respond_to do |format|
      format.xlsx { render xlsx: @posts }
    end
  end
end
```

## Model

Add `xlsx_columns` method for model:

```ruby
class Post < ApplicationRecord
   def xlsx_columns
     [:id, :title, :body]
   end
end
```

or

```ruby
class Post < ApplicationRecord
   belongs_to :category

   def xlsx_columns
     [
       [:category, category.name],
       :title,
       :body
    ]
   end
end
```

## View

If you want to render with template, you can create the template with the .xlsx.xrb extension (index.xlsx.xrb for example)

```ruby
xlsx.write_worksheet do |sheet|
  @posts.find_each do |post|
    sheet.add_row [post.id, post.title]
  end
end
```

## This gem is inspired by the following

[spreadsheet_architect](https://github.com/westonganger/spreadsheet_architect)

[caxlsx_rails](https://github.com/caxlsx/caxlsx_rails)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
