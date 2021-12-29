require "rconcr"

struct Players
  property count : Int32 | Nil
  property max : Int32 | Nil
  property list : Array(String) | Nil

  def initialize()
    @count = nil
    @max = nil
    @list = nil
  end
end

class Who

  def players(host, port, password)
    RCON::Client.open(host, port, password) do |client|
      response = client.command "/list"
      if response
        response
      else
        abort "Server closed connection"
      end
    end
  end

  def parse_players(string)
    matches = /There are (\d) of a max of (\d) players online: (.*)\n/.match(string)
    return nil if !matches
    list = matches.try &.[3]

    count = matches[1].to_i || nil
    max = matches[2].to_i || nil

    players = Players.new
    players.count = count
    players.max = max
    players.list = split_player_names(list)
    players
  end

  def split_player_names(string)
    return [] of String if string == ""
    string.split(",").map(&.strip)
  end

  def text(players)
    return nil if !players

    # make variables here from the players struct because
    # crystal has trouble understanding the types in a struct (idk) and you get type errors
    list = players.list
    if list && list.size == 0
      player_names = "<nobody>"
    else
      player_names = list ? list.join("|") : "UNKNOWN"
    end

    count = players.count ? players.count : "UNKNOWN"
    max = players.max ? players.max : "UNKNOWN"

    "[#{count}/#{max}] #{player_names}"
  end

end