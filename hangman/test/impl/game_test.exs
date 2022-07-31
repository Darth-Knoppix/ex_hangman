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
end
