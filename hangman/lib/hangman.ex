defmodule Hangman do
  @moduledoc """
  Documentation for `Hangman`.
  """

  alias Hangman.Impl.Game
  alias Hangman.Type

  @opaque game :: Game.t()

  @doc """
  Create a new game
  """
  @spec new_game :: game
  defdelegate new_game, to: Game

  @spec make_move(game, String.t()) :: {game, Type.tally()}
  @doc """
  Make a move based on the game and guess
  """
  defdelegate make_move(game, guess), to: Game
end
