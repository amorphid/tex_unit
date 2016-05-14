defmodule TexUnit do
  alias TexUnit.Stack

  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      import TexUnit
      require Stack
      __MODULE__ |> Stack.initialize
    end
  end

  defmacro describe(description, block) do
    quote do
      {__MODULE__, unquote(description)} |> Stack.push
      unquote(block)
      __MODULE__ |> Stack.pop
    end
  end

  defmacro it(description, block) do
    quote do
      descriptions =
        __MODULE__
        |> Stack.stack
        |> Enum.map(fn context -> context.description end)
      full_description =
        [unquote(description) | descriptions]
        |> Enum.reverse
        |> Enum.join(" ")
      unique_id = "(##{:erlang.unique_integer([:positive, :monotonic])})"
      unique_description = "#{full_description} #{unique_id}"
      ExUnit.Case.test(unique_description, unquote(block))
    end
  end
end
