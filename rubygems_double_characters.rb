require 'mechanize'

mechanize = Mechanize.new

search_url = %(https://rubygems.org/search?utf8=%E2%9C%93&query=name%3A+)
('aa'..'zz').each do |char|
  search_page = mechanize.get(search_url + char)
  gem_titles = search_page.search('h2.gems__gem__name')
  gem_names = gem_titles.map { |title| title.at(:span).remove; title.inner_text.strip.downcase }
  if gem_names.include?(char)
    # puts "'#{char}'空いてません"
  else
    puts "'#{char}'空いてます!!!!!!"
  end
end
