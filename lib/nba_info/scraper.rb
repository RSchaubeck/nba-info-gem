class NbaInfo::Scraper

  def self.scrape_team
    html = open("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    nba = {:east => [], :west => []}
    names = doc.css('span.hide-mobile a')
    names.each_with_index do |t, i|
      if i < 15
        nba[:east] << {
          name: t.text,
          place: i + 1
      }
      else
        nba[:west] << {
          name: t.text,
          place: i - 14
      }
      end
    end
    nba
  end

  def self.scrape_stats
    html = open("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    nba = {:east => [], :west => []}
    records = doc.css('table.Table2__table-scroller tbody.Table2__tbody tr')
    records.each_with_index do |r, i|
      wins = r.css('td:first-child span').text
      loss = r.css('td:nth-child(2) span').text
      record = "#{wins} - #{loss}"
      gb = r.css('td:nth-child(4) span').text
      strk = r.css('td:nth-child(12) span').text
      if i < 15
        nba[:east] << {
          record: record,
          gb: gb,
          streak: strk
        }
      else
        nba[:west] << {
          record: record,
          gb: gb,
          streak: strk
        }
      end
    end
    nba
  end


end
