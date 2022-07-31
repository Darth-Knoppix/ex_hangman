defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "returns implementation" do
    game = Hangman.new_game()
    assert is_map(game)
  end
end
