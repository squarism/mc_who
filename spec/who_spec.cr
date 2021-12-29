require "./spec_helper"

# crystal doesn't have mocking :(
# "There are 0 of a max of 2 players online: \n"
# "There are 1 of a max of 2 players online: PlayerName\n"
# "There are 2 of a max of 2 players online: Me, You\n"

describe "Who" do

  # TODO: split config concerns out to a new class
  # describe "configuration and flags" do
  # end

  describe "player parsing" do

    it "returns no players" do
      players = "There are 0 of a max of 2 players online: \n"

      expected = Players.new
      expected.count = 0
      expected.max = 2
      expected.list = [] of String

      Who.new.parse_players(players).should eq expected
    end

    it "returns a single player" do
      players = "There are 1 of a max of 2 players online: Bob\n"

      expected = Players.new
      expected.count = 1
      expected.max = 2
      expected.list = ["Bob"]

      Who.new.parse_players(players).should eq expected
    end

    it "returns many players" do
      players = "There are 2 of a max of 4 players online: Bob, Mary\n"

      expected = Players.new
      expected.count = 2
      expected.max = 4
      expected.list = ["Bob", "Mary"]

      Who.new.parse_players(players).should eq expected
    end
  end

  describe "player name parsing" do
    it "handles empty" do
      Who.new.split_player_names("").should eq [] of String
    end

    it "handles single" do
      Who.new.split_player_names("Bob").should eq ["Bob"]
    end

    it "handles many" do
      Who.new.split_player_names("Bob, Ted").should eq ["Bob", "Ted"]
    end
  end

  describe "formatting" do
    it "prints the player info as text" do
      players = Players.new
      players.count = 2
      players.max = 2
      players.list = ["Bob", "Ted"]

      Who.new.text(players).should eq "[2/2] Bob|Ted"
    end
  end

end