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
      ppg = r.css('td:nth-child(9) span').text
      opp_ppg = r.css('td:nth-child(10) span').text
      strk = r.css('td:nth-child(12) span').text
      l_ten = r.css('td:last-child span').text
      if i < 15
        nba[:east] << {
          record: record,
          gb: gb,
          ppg: ppg,
          opp_ppg: opp_ppg,
          streak: strk,
          l_ten: l_ten
        }
      else
        nba[:west] << {
          record: record,
          gb: gb,
          ppg: ppg,
          opp_ppg: opp_ppg,
          streak: strk,
          l_ten: l_ten
        }
      end
    end
    nba
  end

  def self.scrape_schedule
    html = open("https://www.si.com/nba/schedule")
    doc = Nokogiri::HTML(html)
    schedule = []
    games = doc.css('table')[0].css('tr:not(:first-child)')
    games.each do |game|
      schedule << {
        away: game.css('td:first-child span.team-abbreviation')[0].text.gsub(/\s+/, ""),
        home: game.css('td:nth-child(2) span.team-abbreviation')[0].text.gsub(/\s+/, ""),
        time: game.css('td:nth-child(3)').text.strip
      }
    end
    schedule
  end


end
