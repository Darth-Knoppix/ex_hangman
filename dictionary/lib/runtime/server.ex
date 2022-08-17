defmodule Dictionary.Runtime.Server do
  use Agent
  alias Dictionary.Impl.WordList

  @name __MODULE__
  @type t :: pid()

  def start_link(_args) do
    Agent.start_link(&WordList.word_list/0, name: @name)
  end

  def random_word() do
    Agent.get(@name, &WordList.random_word/1)
  end
end
