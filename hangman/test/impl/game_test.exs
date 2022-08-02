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
        {new_game, _tally} = Game.make_move(game, "x")

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

    test "recognize a letter in a word" do
      game = Game.new_game("rice")
      {game, tally} = Game.make_move(game, "i")
      assert tally.game_state == :good_guess
      {game, tally} = Game.make_move(game, "r")
      assert tally.game_state == :good_guess
    end

    test "recognize an incorrect guess" do
      game = Game.new_game("rice")
      turns_left = game.turns_left
      {game, tally} = Game.make_move(game, "x")
      assert tally.game_state == :bad_guess
      assert tally.turns_left == turns_left - 1
    end

    test "can handle sequence of moves" do
      [
        ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
        ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
        ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]],
        ["l", :good_guess, 5, ["_", "e", "l", "l", "_"], ["a", "e", "l", "x"]],
        ["h", :good_guess, 5, ["h", "e", "l", "l", "_"], ["a", "e", "h", "l", "x"]]
      ]
      |> test_sequence_of_moves()
    end

    defp test_sequence_of_moves(script) do
      game = Game.new_game("hello")
      Enum.reduce(script, game, &check_move/2)
    end

    defp check_move([guess, state, turns, letters, used], game) do
      {game, tally} = Game.make_move(game, guess)

      assert tally.game_state == state
      assert tally.turns_left == turns
      assert tally.letters == letters
      assert tally.used == used
      game
    end
  end
end
