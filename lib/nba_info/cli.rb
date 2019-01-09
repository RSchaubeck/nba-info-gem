class NbaInfo::CLI

  def call
    puts <<-DOC.gsub /^\s*/, ''
      Welcome to the NBA Info CLI gem!
      List of commands:
      schedule - shows todays schedule
      standings - shows current standings
      Lastly, you can type the name of the team (omit the city e.g. knicks, warriors)
      to get more info about them
    DOC
  end

end
