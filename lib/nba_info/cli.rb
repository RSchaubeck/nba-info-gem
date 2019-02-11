class NbaInfo::CLI

  def call
    instruct
    input = gets.strip
    until input == "exit"
      case input
      when "commands"
        instruct
        input = gets.strip
      when "key"
        key
        input = gets.strip
      when "schedule"
        schedule
        input = gets.strip
      when "standings"
        standings
        input = gets.strip
      when "team"
        team
        input = gets.strip
      else
        puts "Not a valid command"
        input = gets.strip
      end
    end
  end

  def instruct
    puts <<-DOC.gsub /^\s*/, ''
      Welcome to the NBA Info CLI gem!
      List of commands:
      commands - show these commands again
      key - show meanings of the stat abbreviations
      schedule - show todays schedule
      standings - show current standings
      team - get more info about a team
      exit - exit program
    DOC
  end

  def schedule
    sched = NbaInfo::Scraper.scrape_schedule
    puts "All times are Eastern Standard"
    sched.each do |game|
      puts "#{game[:away].ljust(4)} @  #{game[:home].ljust(4)} -  #{game[:time]}"
    end
    ""
  end

  def standings
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
    nba = NbaInfo::Team.add_stats
    puts "Type the name of a team (omit the city from the search e.g. new york knicks would just be knicks)"
    input = gets.strip.capitalize
    if nba[:east].any?{|team| team.name.include?(input)}
      team = nba[:east].detect{|t| t.name.include?(input)}
      puts "#{team.name}(#{team.record}) -- PPG: #{team.ppg} -- OPP PPG: #{team.opp_ppg} -- L10: #{team.l_ten} -- Strk: #{team.streak}"
    elsif nba[:west].any?{|team| team.name.include?(input)}
      team = nba[:west].detect{|t| t.name.include?(input)}
      puts "#{team.name}(#{team.record}) -- PPG: #{team.ppg} -- OPP PPG: #{team.opp_ppg} -- L10: #{team.l_ten} -- Strk: #{team.streak}"
    else
      "Make sure you omitted the city and spelled the team name correctly"
    end
    ""
  end

  def key
    puts <<-DOC.gsub /^\s*/, ''
      GB - games back
      PPG - points per game
      OPP PPG - opponents points per game
      L10 - last 10
      Strk - streak
    DOC
  end

end
