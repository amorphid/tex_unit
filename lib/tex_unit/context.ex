defmodule TexUnit.Context do
  def new({description, flag}) do
    %{description: description,
      flag:        do_flag(flag)}
  end

  defp do_flag(flags) when is_list(flags) do
    Enum.map(flags, fn flag -> do_flag(flag) end)
  end

  defp do_flag(flag) when is_atom(flag) and flag != false
                                        and flag != nil
                                        and flag != true do
    {flag, true}
  end

  defp do_flag(flag) do
    flag
  end
end
