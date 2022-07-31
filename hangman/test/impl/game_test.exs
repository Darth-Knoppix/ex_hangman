defmodule Hangman.Impl.GameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  describe "new game" do
    test "returns correct structure" do
      game = Game.new_game()

      assert game.game_state == :initializing
      assert game.turns_left == 7
      assert length(game.letters) > 0
    end

    test "returns correct word" do
      game = Game.new_game("lettuce")

      assert game.letters == ["l", "e", "t", "t", "u", "c", "e"]
    end

    test "returns lowercase words" do
      game = Game.new_game("Salamander")

      assert game.letters == ["s", "a", "l", "a", "m", "a", "n", "d", "e", "r"]
    end
  end

  describe "make move" do
    test "state doesn't change if game is won or lost" do
      for state <- [:won, :lost] do
        game = Game.new_game("cheese")
        game = Map.put(game, :game_state, state)
        {new_game, tally} = Game.make_move(game, "x")

        assert new_game == game
      end
    end

    test "duplicate letter is reported" do
      {game, _tally} = Game.new_game() |> Game.make_move("a")
      assert game.game_state != :already_used

      {game, _tally} = game |> Game.make_move("a")
      assert game.game_state == :already_used
    end

    test "letters are recorded" do
      game = Game.new_game()

      {game, _tally} = game |> Game.make_move("a")
      {game, _tally} = game |> Game.make_move("b")
      {game, _tally} = game |> Game.make_move("c")
      {game, _tally} = game |> Game.make_move("d")

      assert MapSet.equal?(game.used, MapSet.new(["a", "b", "c", "d"]))
    end
  end
end
