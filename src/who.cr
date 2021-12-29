require "rconcr"

struct Players
  property count : Int32 | String
  property max : Int32 | String
  property list : Array(String) | String

  def initialize()
    @count = "UNKNOWN"
    @max = "UNKNOWN"
    @list = "UNKNOWN"
  end
end

class Who

  def players
    RCON::Client.open(ENV["MCWHO_HOST"], ENV["MCWHO_PORT"], ENV["MCWHO_RCON_PASSWORD"]) do |client|
      response = client.command "/list"
      if response
        response
      else
        abort "Server closed connection"
      end
    end
  end

  def env_valid?
    begin
      ENV["MCWHO_HOST"] != nil && ENV["MCWHO_PORT"] != nil && ENV["MCWHO_RCON_PASSWORD"] != nil
    rescue KeyError
      false
    end
  end

  def parse_players(string)
    matches = /There are (\d) of a max of (\d) players online: (.*)\n/.match(string)
    return nil if !matches
    list = matches.try &.[3]

    count = matches[1].to_i || "UNKNOWN"
    max = matches[2].to_i || "UNKNOWN"

    players = Players.new
    players.count = count
    players.max = max
    players.list = split_player_names(matches.try &.[3])
    players
  end

  def split_player_names(string)
    return [] of String if string == ""
    string.split(",").map(&.strip)
  end

end