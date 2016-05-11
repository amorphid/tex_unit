defmodule TexasUnit do
  alias TexasUnit.Stack

  defmacro __using__(opts) do
    quote do
      use ExUnit.Case
      import TexasUnit
      require Stack
      Stack.initialize
    end
  end

  defmacro describe(description, block) do
    quote do
      unquote(description) |> Stack.push
      unquote(block)
      Stack.pop
    end
  end

  defmacro it(description, block) do
    quote do
      full_description =
        [unquote(description)|Module.get_attribute(__MODULE__, :descriptions)]
        |> Enum.reverse
        |> Enum.join(" ")
      unique_id = "(##{:erlang.unique_integer([:positive, :monotonic])})"
      unique_description = "#{full_description} #{unique_id}"
      ExUnit.Case.test(unique_description, unquote(block))
    end
  end
end
