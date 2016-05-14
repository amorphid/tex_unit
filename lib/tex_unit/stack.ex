defmodule TexUnit.Stack do
  alias TexUnit.Context
  require Context

  defmacro initialize(module) do
    quote do
      unquote(put_stack(module, []))
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

  defmacro stack(module) do
    quote do
      unquote(get_stack(module))
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
