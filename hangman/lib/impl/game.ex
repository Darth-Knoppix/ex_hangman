defmodule Hangman.Impl.Game do
  @moduledoc """
  Hangman game implementation
  """

  alias Hangman.Type

  @type t :: %__MODULE__{
          turns_left: integer(),
          game_state: Type.Hangman.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{letters: word |> String.downcase() |> String.codepoints()}
  end

  @spec make_move(t, String.t()) :: {t, Type.tally()}
  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game |> with_tally()
  end

  def make_move(game, guess) do
    accept_guess(game, guess, MapSet.member?(game.used, guess)) |> with_tally()
  end

  defp accept_guess(game, _guess, _used = true) do
    %__MODULE__{game | game_state: :already_used}
  end

  defp accept_guess(game, guess, _used = false) do
    %__MODULE__{game | used: MapSet.put(game.used, guess)}
  end

  defp with_tally(game) do
    {game, tally(game)}
  end

  @spec tally(t) :: t
  defp tally(game) do
    %__MODULE__{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: game.letters,
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end
end
