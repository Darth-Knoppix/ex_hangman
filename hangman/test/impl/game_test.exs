defmodule HangmanTest.Impl.Game do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.game_state == :initializing
    assert game.turns_left == 7
    assert length(game.letters) > 0
  end
end
