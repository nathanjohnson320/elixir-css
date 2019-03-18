defmodule Test.CssComponents do
    def button(attributes, inner) do
        attributes
        |> Enum.map(fn({name, attr}) ->
            "#{name}=\"#{attr}\""
        end)
        |> Enum.join(" ")
        
        "<button #{attributes}>#{inner}</button>"
    end
end