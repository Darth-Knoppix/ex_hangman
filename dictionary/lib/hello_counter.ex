defmodule HelloCounter do
  def greet(count \\ 0) do
    receive do
      msg ->
        IO.puts("Hello #{msg}, for the #{Integer.to_string(count + 1)} time!")
    end

    greet(count + 1)
  end
end
