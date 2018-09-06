require 'mechanize'

mechanize = Mechanize.new

search_url = %(https://rubygems.org/search?utf8=%E2%9C%93&query=name%3A+)
('a'..'z').each do |char|
  search_page = mechanize.get(search_url + char)
  gem_titles = search_page.search('h2.gems__gem__name')
  gem_names = gem_titles.map { |title| title.at(:span).remove; title.inner_text.strip }
  if !gem_names.include?(char) && !gem_names.include?(char.upcase)
    puts "'#{char}'空いてます!!!!!!"
  else
    puts "'#{char}'空いてません"
  end
end
