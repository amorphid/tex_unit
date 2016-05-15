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

  defmacro describe(description \\ "", block) do
    quote do
      flag = Module.get_attribute(__MODULE__, :flag)
      Module.put_attribute(__MODULE__, :flag, nil)
      {__MODULE__, {unquote(description), flag}} |> Stack.push
      unquote(block)
      __MODULE__ |> Stack.pop
    end
  end

  defmacro it(description \\ "", block) do
    quote do
      flag = Module.get_attribute(__MODULE__, :flag)
      {__MODULE__, {unquote(description), flag}} |> Stack.push
      Module.put_attribute(__MODULE__, :flag, nil)

      flags =
      __MODULE__
        |> Stack.stack
        |> Enum.map(fn context -> context.flag end)
        |> Enum.reject(fn i -> is_nil(i) end)
        |> List.flatten
        |> Enum.reverse
        |> Enum.into(%{})
        |> Enum.to_list
      descriptions =

      full_description =
          __MODULE__
        |> Stack.stack
        |> Enum.map(fn context -> context.description end)
        |> Enum.reverse
        |> Enum.join(" ")

      __MODULE__ |> Stack.pop

      unique_id = "(##{:erlang.unique_integer([:positive, :monotonic])})"
      unique_description = "#{full_description} #{unique_id}"
      Module.put_attribute(__MODULE__, :tag, flags)
      Module.put_attribute(__MODULE__, :__flag__, flags)
      ExUnit.Case.test(unique_description, unquote(block))
    end
  end
end
