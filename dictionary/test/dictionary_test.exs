defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "gets a list of strings" do
    words = Dictionary.word_list()
    assert is_list(words)
    assert is_binary(List.first(words))
  end
end
