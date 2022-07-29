defmodule Hangman do
  @moduledoc """
  Documentation for `Hangman`.
  """

  @type game :: any
  @type tally :: %{
          turns_left: integer(),
          game_state: any(),
          letters: list(String.t()),
          used: list(String.t())
        }

  @spec new_game :: game
  @doc """
  Create a new game
  """
  def new_game do
  end

  @spec make_move(game, String.t()) :: {game, tally}
  @doc """
  Make a move based on the game and guess
  """
  def make_move(game, guess) do
  end
end
