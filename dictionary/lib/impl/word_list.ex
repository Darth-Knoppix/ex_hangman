defmodule Dictionary.Impl.WordList do
  @type t :: list(String)

  # Read words at compile
  @spec word_list() :: t
  def word_list do
    "assets/web2.txt"
    |> File.read!()
    |> String.downcase()
    |> String.split(~R{\n}, trim: true)
  end

  @doc """
  Get a random word from the word list

  ## Examples

      iex> :rand.seed(:exsplus, {1,2,3})
      iex> word_list = Dictionary.Impl.WordList.word_list()
      iex> Dictionary.Impl.WordList.random_word(word_list)
      "hamperer"

  """
  @spec random_word(t) :: String.t()
  def random_word(word_list) do
    word_list |> Enum.random()
  end
end
