defmodule Dictionary.Runtime.Server do
  @name __MODULE__
  @type t :: pid()

  alias Dictionary.Impl.WordList

  def start_link() do
    Agent.start_link(&WordList.word_list/0, name: @name)
  end

  def random_word() do
    Agent.get(@name, &WordList.random_word/1)
  end
end
