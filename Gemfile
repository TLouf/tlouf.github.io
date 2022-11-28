source "https://rubygems.org"

# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!

gem "github-pages", group: :jekyll_plugins

# If you want to use Jekyll native, uncomment the line below.
# To upgrade, run `bundle update`.

gem 'jekyll', "< 3.9.2"

gem "wdm", "~> 0.1.0" if Gem.win_platform?

gem "webrick"

# If you have any plugins, put them here!
group :jekyll_plugins do
  # gem "jekyll-archives"
  gem "jekyll-feed"
  gem 'jekyll-sitemap'
  gem 'hawkins'
end

# pb: cannot install ruby < 3 because of openssl update
# does not work for jekyll > 3.9.0 b/c https://github.com/academicpages/academicpages.github.io/issues/943
# cannot use jekyll 3.9.0 on ruby 3 bc pathutil.rb:502:in `read': no implicit conversion of Hash into Integer
# Solution: this is absolutely horrible, BUT it works: jekyll 3.9.0 with manual fix in 
# https://github.com/envygeeks/pathutil/commit/3451a10c362fc867b20c7e471a551b31c40a0246#diff-5372ed4218752c3077f741296df57da67756dca1d282c64fcced144fc82cd204
