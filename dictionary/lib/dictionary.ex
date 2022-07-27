defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  """

  @doc """
  Get a random word from the word list

  ## Examples

      iex> :rand.seed(:exsplus, {1,2,3})
      iex> Dictionary.random_word()
      "hamperer"

  """
  def random_word do
    {:ok, wordlist} = File.read("assets/web2.txt")
    words = String.split(wordlist)
    Enum.random(words)
  end
end
