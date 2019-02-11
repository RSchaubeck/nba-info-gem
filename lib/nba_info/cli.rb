class NbaInfo::CLI

  def call

  end

  def instruct
    puts <<-DOC.gsub /^\s*/, ''
      Welcome to the NBA Info CLI gem!
      List of commands:
      commands - shows list of commands
      schedule - shows todays schedule
      standings - shows current standings
      Lastly, you can type the name of a team (omit the city e.g. knicks, warriors)
      to get more info about them
    DOC
  end

  def self.schedule
    sched = NbaInfo::Scraper.scrape_schedule
    puts "All times are Eastern Standard"
    sched.each do |game|
      puts "#{game[:away].ljust(4)} @  #{game[:home].ljust(4)} -  #{game[:time]}"
    end
    ""
  end

  def self.standings
    nba = NbaInfo::Team.add_stats
    puts <<-DOC.gsub /^\s*/, ''
      EASTERN CONFERENCE
      Team                   |Record   | GB
      ----------------------------------------
    DOC
    nba[:east].each do |team|
      puts "#{team.name.ljust(23)} #{team.record.ljust(9)} #{team.gb}"
    end
    puts <<-DOC.gsub /^\s*/, ''
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      WESTERN CONFERENCE
      Team                   |Record   | GB
      ----------------------------------------
    DOC
    nba[:west].each do |team|
      puts "#{team.name.ljust(23)} #{team.record.ljust(9)} #{team.gb}"
    end
    ""
  end

  def team
  end

end
