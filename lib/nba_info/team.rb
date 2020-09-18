class NbaInfo::Team

  attr_accessor :name, :place, :record, :win_pct, :gb, :ppg, :opp_ppg, :diff, :streak, :l_ten

  @@nba = {:east => [], :west => []}

  def initialize(team_hash)
    team_hash.each do |key, val|
      self.send "#{key}=", val
    end
  end

  def self.create
    nba = NbaInfo::Scraper.scrape_team
    if @@nba[:east].empty? || @@nba[:west].empty?
      nba[:east].each do |team|
        t = self.new(team)
        @@nba[:east] << t
      end
      nba[:west].each do |team|
        t = self.new(team)
        @@nba[:west] << t
      end
    end
    @@nba
  end

  def self.add_stats
    self.create
    stats = NbaInfo::Scraper.scrape_stats
    @@nba[:east].each_with_index do |team, i|
      stats[:east][i].each do |key, val|
        team.send "#{key}=", val
      end
    end
    @@nba[:west].each_with_index do |team, i|
      stats[:west][i].each do |key, val|
        team.send "#{key}=", val
      end
    end
    @@nba
  end

end
