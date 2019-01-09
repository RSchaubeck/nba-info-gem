class NbaInfo::Team

  attr_accessor :name, :place

  @@east = []
  @@west = []

  def self.scrape_team
    html = open("http://www.espn.com/nba/standings")
    doc = Nokogiri::HTML(html)
    names = doc.css('span.hide-mobile a')
    names.each_with_index do |t, i|
      team = self.new
      team.name = t.text
      if i + 1 < 16
        team.place = i + 1
        @@east << team
      else
        team.place = i - 14
        @@west << team
      end
    end
    binding.pry
  end

end
