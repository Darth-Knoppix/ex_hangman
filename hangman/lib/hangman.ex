defmodule Hangman do
  @moduledoc """
  Documentation for `Hangman`.
  """

  alias Hangman.Impl.Game

  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @opaque game :: Game.t()
  @type tally :: %{
          turns_left: integer(),
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }

  @doc """
  Create a new game
  """
  @spec new_game :: game
  defdelegate new_game, to: Game

  @spec make_move(game, String.t()) :: {game, tally}
  @doc """
  Make a move based on the game and guess
  """
  def make_move(_game, _guess) do
  end
end
