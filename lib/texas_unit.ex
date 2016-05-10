defmodule TexasUnit do
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case
      import TexasUnit
      Module.put_attribute(__MODULE__, :stack, [])
    end
  end

  defmacro describe(description, block) do
    quote do
      old_stack = Module.get_attribute(__MODULE__, :stack)
      new_stack = [unquote(description)|old_stack]
      Module.put_attribute(__MODULE__, :stack, new_stack)
      unquote(block)
      Module.put_attribute(__MODULE__, :stack, old_stack)
    end
  end

  defmacro it(description, block) do
    quote do
      full_description =
        [unquote(description)|Module.get_attribute(__MODULE__, :stack)]
        |> Enum.reverse
        |> Enum.join(" ")
      ExUnit.Case.test(full_description, unquote(block))
    end
  end
end
