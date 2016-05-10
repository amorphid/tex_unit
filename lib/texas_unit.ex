defmodule TexasUnit do
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case
      import TexasUnit
    end
  end

  defmacro it(description, block) do
    quote do
      ExUnit.Case.test(unquote(description), unquote(block))
    end
  end
end
