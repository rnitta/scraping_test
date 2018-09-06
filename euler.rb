require 'pp'
require 'mechanize'
require 'json'

result = {}
agent = Mechanize.new
projects_page = agent.get('http://odz.sakura.ne.jp/projecteuler/index.php?Project%20Euler')
links = projects_page.search('h3#content_1_3 + ul a')
links.each do |link|
  problem = agent.get(link.get_attribute(:href))
  m = /\w+\s+(\d+)/.match(problem.at('div#body h2 a').inner_text)
  problem.search('div#body h2 a').each(&:remove)
  title = problem.at('div#body h2').inner_text.strip.gsub(/「|」/, '')
  body = problem.search('div#body p').inject('') {|str, node| str += node.inner_text}
  result[m[1].to_i] = {title: title, body: body }
  p m[1].to_i
end

File.open("euler.json", 'w') do |file|
  JSON.dump(result, file)
end
