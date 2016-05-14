defmodule TexUnit.Stack do
  defmacro initialize(module) do
    quote do
      unquote(put_stack(module, []))
    end
  end

  defmacro push({module, description}) do
    quote do
      old_stack = unquote(get_stack(module))
      new_stack = [unquote(description) | old_stack]
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
      Module.get_attribute(unquote(module), :descriptions)
    end
  end

  defp put_stack(module, stack) do
    quote do
      Module.put_attribute(unquote(module), :descriptions, unquote(stack))
    end
  end
end
