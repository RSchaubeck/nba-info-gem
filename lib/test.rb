require 'pry'
require 'JSON'
require 'HTTParty'
require 'nokogiri'

html = HTTParty.get('http://www.espn.com/nba/standings')
doc = Nokogiri::HTML(html)
records = doc.css('div.Table__ScrollerWrapper table tbody tr')

Pry.start(binding)