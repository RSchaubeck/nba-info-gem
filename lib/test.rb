require 'pry'
require 'JSON'
require 'HTTParty'
require 'nokogiri'

html = HTTParty.get('https://www.cbssports.com/nba/schedule/')
doc = Nokogiri::HTML(html)
records = doc.css('table.TableBase-table tbody tr')

Pry.start(binding)