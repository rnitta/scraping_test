require 'mechanize'

result = {}
agent = Mechanize.new
page = agent.get('https://ja.wikipedia.org/wiki/Unicode%E3%81%AEEmoji%E3%81%AE%E4%B8%80%E8%A6%A7')
tds = page.search('table.sortable tr:not(:first-child) td:nth-child(2)')
hoge = tds.map{ |aaa| aaa.inner_text().delete('U+').to_i(16) }

max_seq = 0
ans = 0
seq = 0
hoge.each_with_index do |a, i|
  if a == hoge[i - 1] +1
    seq += 1
  else
    seq = 0
  end
  if seq > max_seq
    ans = a
    max_seq = seq
  end
end
center =  (ans - max_seq) -1
p center
p center.to_s(16)
