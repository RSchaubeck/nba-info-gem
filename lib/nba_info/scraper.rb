class NbaInfo::Scraper

  @@nba = {"east" => [], "west" => []}


  def self.scrape_team(url)
    html = open("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    names = doc.css('span.hide-mobile a')
    names.each_with_index do |t, i|
      team = self.new
      team.name = t.text
      if i + 1 < 16
        team.place = i + 1
        @@nba["east"] << team
      else
        team.place = i - 14
        @@nba["west"] << team
      end
    end
    @@nba
  end

  def self.record(url)
    html = open("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    records = doc.css('table.Table2__table-scroller tbody.Table2__tbody tr')
    records.each_with_index do |r, i|
      wins = r.css('td:first-child span').text
      loss = r.css('td:nth-child(2) span').text
      record = "#{wins} - #{loss}"
      if i < 16
        @@nba["east"][i].record = record
      else
        @@nba["west"][i].record = record
      end
    end
    @@nba
  end

  def all
    @@nba
  end


end
