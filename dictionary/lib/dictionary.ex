defmodule Dictionary do
  def word_list do
    "assets/web2.txt"
    |> File.read!()
    |> String.downcase()
    |> String.split(~R{\n}, trim: true)
  end

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
    word_list() |> Enum.random()
  end
end
