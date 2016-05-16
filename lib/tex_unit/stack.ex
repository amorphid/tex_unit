defmodule TexUnit.Stack do
  alias TexUnit.Context
  require Context

  defmacro initialize(module) do
    quote do
      unquote(put_stack(module, []))
    end
  end

  defmacro flags(module) do
    quote do
      unquote(get_stack(module))
      |> Enum.map(fn context -> context.flag end)
      |> Enum.reject(fn i -> is_nil(i) end)
      |> List.flatten
      |> Enum.reverse
      |> Enum.into(%{})
      |> Enum.to_list
    end
  end

  defmacro new_description(module) do
    quote do
      full_description =
        unquote(get_stack(module))
        |> Enum.map(fn context -> context.description end)
        |> Enum.reverse
        |> Enum.join(" ")
      unique_id = "(##{:erlang.unique_integer([:positive, :monotonic])})"
      "#{full_description} #{unique_id}"
    end
  end

  defmacro push({module, context}) do
    quote do
      old_stack = unquote(get_stack(module))
      context   = unquote(context) |> Context.new
      new_stack = [context | old_stack]
      unquote(put_stack(module, quote do new_stack end))
    end
  end

  defmacro pop(module) do
    quote do
      [_ | new_stack] = unquote(get_stack(module))
      unquote(put_stack(module, quote do new_stack end))
    end
  end

  defp get_stack(module) do
    quote do
      Module.get_attribute(unquote(module), :stack)
    end
  end

  defp put_stack(module, stack) do
    quote do
      Module.put_attribute(unquote(module), :stack, unquote(stack))
    end
  end
end

