require "admiral"
require "./who.cr"

class Main < Admiral::Command
  define_help description: "Minecraft Who"

  define_flag host : String,
    description: "The Minecraft server IP, not a DNS name",
    long: host,
    short: h,
    required: true

  define_flag port : Int32,
    description: "The Minecraft RCON port, not the game port",
    default: 25575,
    long: port,
    short: p

  define_flag rcon_password : String,
    description: "The RCON password",
    long: password,
    short: r,
    required: true

  def run
    who = Who.new
    response = who.players(flags.host, flags.port, flags.rcon_password)
    players = who.parse_players(response)
    puts who.text(players)
  end
end

Main.run