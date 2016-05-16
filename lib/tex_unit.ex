defmodule TexUnit do
  alias TexUnit.Stack

  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      import TexUnit
      require Stack
      __MODULE__ |> Stack.initialize
      Module.register_attribute(__MODULE__, :flag, [])
    end
  end

  defmacro context(description \\ "", block) do
    quote do
      unquote(do_describe(description, block))
    end
  end

  defmacro describe(description \\ "", block) do
    quote do
      unquote(do_describe(description, block))
    end
  end

  defmacro it(description \\ "", block) do
    quote do
      unquote(description |> push)

      flags = __MODULE__ |> Stack.flags
      Module.put_attribute(__MODULE__, :tag, flags)
      Module.put_attribute(__MODULE__, :__flag__, flags)

      new_description = __MODULE__ |> Stack.new_description

      ExUnit.Case.test(new_description, unquote(block))

      unquote(pop)
    end
  end

  defp do_describe(description, block) do
    quote do
      unquote(description |> push)
      unquote(block)
      unquote(pop)
    end
  end

  defp push(description) do
    quote do
      flag = Module.get_attribute(__MODULE__, :flag)
      Module.put_attribute(__MODULE__, :flag, nil)
      {__MODULE__, {unquote(description), flag}} |> Stack.push
    end
  end

  defp pop do
    quote do
      __MODULE__ |> Stack.pop
    end
  end
end
