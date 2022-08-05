defmodule TextClient.Impl.Player do
  alias Hangman.Impl.Game

  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  def start do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok

  def interact({_game, %{game_state: :won}}) do
    IO.puts(IO.ANSI.green() <> "You won" <> IO.ANSI.reset())
  end

  def interact({game, %{game_state: :lost}}) do
    IO.puts(
      "You " <>
        IO.ANSI.red() <>
        "lost" <>
        IO.ANSI.reset() <>
        ", the word was " <>
        IO.ANSI.italic() <> IO.ANSI.blue() <> "#{Enum.join(game.letters)}" <> IO.ANSI.reset()
    )
  end

  def interact({game, tally}) do
    tally |> feedback_for |> IO.puts()
    tally |> current_word() |> IO.puts()

    Hangman.make_move(game, get_guess())
    |> interact()
  end

  def feedback_for(%{game_state: :good_guess}),
    do: IO.ANSI.green() <> "Good guess!" <> IO.ANSI.reset()

  def feedback_for(%{game_state: :bad_guess}),
    do: IO.ANSI.yellow() <> "That letter is not in the word." <> IO.ANSI.reset()

  def feedback_for(%{game_state: :already_used}),
    do: IO.ANSI.underline() <> "You've already guessed that letter before." <> IO.ANSI.reset()

  def feedback_for(%{game_state: :initializing, letters: letters}) do
    "I'm thinking of a word with " <>
      IO.ANSI.italic() <> "#{Enum.count(letters)}" <> IO.ANSI.reset() <> " letters"
  end

  def current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      "  turns left: ",
      IO.ANSI.underline(),
      tally.turns_left |> to_string(),
      IO.ANSI.reset(),
      "  used so far: ",
      tally.used |> Enum.join(",")
    ]
  end

  def get_guess do
    IO.gets("Next letter: ")
    |> String.trim()
    |> String.downcase()
  end
end
