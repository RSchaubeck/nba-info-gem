class NbaInfo::Team

  attr_accessor :name, :place, :record, :gb, :streak

  @@nba = {:east => [], :west => []}

  def initialize(team_hash)
    team_hash.each do |key, val|
      self.send "#{key}=", val
    end
  end

  def self.create
    nba = NbaInfo::Scraper.scrape_team
    nba[:east].each do |team|
      t = self.new(team)
      @@nba[:east] << t
    end
    nba[:west].each do |team|
      t = self.new(team)
      @@nba[:west] << t
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

  def all
    @@nba
  end

  def east
    @@nba[:east]
  end

  def west
    @@nba[:west]
  end

end
