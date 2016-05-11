defmodule TexasUnit.Stack do
  defmacro initialize do
    quote do
      Module.put_attribute(__MODULE__, :descriptions, [])
    end
  end

  defmacro push(description) do
    quote do
      old_stack = Module.get_attribute(__MODULE__, :descriptions)
      new_stack = [unquote(description)|old_stack]
      Module.put_attribute(__MODULE__, :descriptions, new_stack)
    end
  end

  defmacro pop do
    quote do
      [_|new_stack] = Module.get_attribute(__MODULE__, :descriptions)
      Module.put_attribute(__MODULE__, :descriptions, new_stack)
    end
  end
end
