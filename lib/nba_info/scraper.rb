class NbaInfo::Scraper

  def self.scrape_team
    html = HTTParty.get('http://www.espn.com/nba/standings')
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
    html = HTTParty.get("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    nba = {:east => [], :west => []}
    records = doc.css('div.Table__ScrollerWrapper table tbody tr')
    records.each_with_index do |r, i|
      wins = r.css('td:first-child span').text
      loss = r.css('td:nth-child(2) span').text
      win_pct = r.css('td:nth-child(3) span').text
      record = "#{wins} - #{loss}"
      gb = r.css('td:nth-child(4) span').text
      ppg = r.css('td:nth-child(9) span').text
      opp_ppg = r.css('td:nth-child(10) span').text
      diff = r.css('td:nth-child(11) span').text
      strk = r.css('td:nth-child(12) span').text
      l_ten = r.css('td:last-child span').text
      if i < 15
        nba[:east] << {
          record: record,
          win_pct: win_pct,
          gb: gb,
          ppg: ppg,
          opp_ppg: opp_ppg,
          diff: diff,
          streak: strk,
          l_ten: l_ten
        }
      else
        nba[:west] << {
          record: record,
          win_pct: win_pct,
          gb: gb,
          ppg: ppg,
          opp_ppg: opp_ppg,
          diff: diff,
          streak: strk,
          l_ten: l_ten
        }
      end
    end
    nba
  end

  def self.scrape_schedule
    html = HTTParty.get("https://www.cbssports.com/nba/schedule/")
    doc = Nokogiri::HTML(html)
    schedule = []
    games = doc.css('table.TableBase-table tbody tr')
    games.each do |game|
      schedule << {
        away: game.css('td:first-child span.TeamName a').text,
        home: game.css('td:nth-child(2) span.TeamName a').text,
        time: game.css('td:nth-child(3) div.CellGame a').text,
        tv: game.css('td:nth-child(3) div.CellGame div.CellGameTv').text.strip
      }
    end
    schedule
  end


end
