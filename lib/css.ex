defmodule Css do
  @moduledoc """
  Documentation for Css.
  """

  @doc ~S"""
  Generates a style tag and a class to be attached to individual components

  ## Examples

      iex> [display_flex(), hover [background_color(rgb("#200F13"))]] |> styled()
      {"aoGhYVFwgcTVVW", ".aoGhYVFwgcTVVW {\n  display: flex;\n}\n.aoGhYVFwgcTVVW:hover {\n  background-color: #200F13;\n}\n"}

  """
  def styled(styles) do
    # Group the styles into pseudo selectors and non
    groups = Enum.group_by(styles, &is_list/1)
    
    # Generate the base classname
    class = (groups[:false] || [])
    |> Enum.sort()
    |> Enum.join("\n")
    |> XXHash.xxh32() 
    |> to_string()
    |> Base49.encode()

    # Generate the base styles
    base_styles = style_string(class, "", groups.false || [])

    # For each pseudo selector generate a stylesheet
    group_styles = (groups[:true] || [])
    |> Enum.flat_map(fn(types) ->
      Enum.map(types, fn({type, style}) ->
        style_string(class, ":#{type}", style)
      end)
    end)

    # Concat the base styles and group styles
    styles = "#{base_styles}#{group_styles}"
    GenServer.call(Css.Cache, {:get_or_set, class, styles})
    
    {class, styles}
  end

  defp style_string(class, type, style) do
".#{class}#{type} {
  #{style}
}
"
  end

  def stylesheet() do
    GenServer.call(Css.Cache, {:stylesheet})
    |> Enum.reduce("", fn({_, class}, styles) -> 
      "#{styles}#{class}"
    end)
  end

  # Pseudo Classes
  def checked(styles), do: [checked: styles]
  def disabled(styles), do: [disabled: styles]
  def hover(styles), do: [hover: styles]
  def focus(styles), do: [focus: styles]
  def visited(styles), do: [visited: styles]
  def invalid(styles), do: [invalid: styles]
  def required(styles), do: [required: styles]

  def rgb(color) do
    color
    |> CssColors.parse!()
  end

  def color(%CssColors.RGB{} = color) do
    "color: #{color |> to_string()};"
  end

  def background_color(%CssColors.RGB{} = color) do
    "background-color: #{color};"
  end

  def display_flex() do
    "display: flex;"
  end

  def flex(l) do
    "flex: #{l};"
  end

  def flex_direction(d) do
    "flex-direction: #{d};"
  end

  def width(w) do
    "width: #{w};"
  end

  def margin(m) do
    "margin: #{m};"
  end

  def padding(p1, p2) do
    "padding: #{p1} #{p2};"
  end

  # Borders
  def border(width, type, %CssColors.RGB{} = color) do
    "border: #{width} #{type} #{color |> to_string()};"
  end

  def border_top_color(%CssColors.RGB{} = color) do
    "border-top-color: #{color |> to_string()};"
  end

  def border_right_color(%CssColors.RGB{} = color) do
    "border-right-color: #{color |> to_string()};"
  end

  def border_bottom_color(%CssColors.RGB{} = color) do
    "border-bottom-color: #{color |> to_string()};"
  end

  def border_left_color(%CssColors.RGB{} = color) do
    "border-left-color: #{color |> to_string()};"
  end

  def border_color(%CssColors.RGB{} = color) do
    "border-color: #{color |> to_string()};"
  end
  def border_color(color) do
    "border-color: #{color};"
  end

  def border_radius(r) do
    "border-radius: #{r};"
  end

  def box_shadow(offset_x, offset_y, blur_radius, %CssColors.RGB{} = color) do
    "box-shadow: #{offset_x} #{offset_y} #{blur_radius} #{color |> to_string()};"
  end
  def box_shadow(offset_x, offset_y, blur_radius, spread_radius, %CssColors.RGB{} = color) do
    "box-shadow: #{offset_x} #{offset_y} #{blur_radius} #{spread_radius} #{color |> to_string()};"
  end
  def box_shadow(offset_x, offset_y, blur_radius, spread_radius, color) do
    "box-shadow: #{offset_x} #{offset_y} #{blur_radius} #{spread_radius} #{color};"
  end
  def box_shadow(s) do
    "box-shadow: #{s};"
  end

  # Text
  def font_size(s) do
    "font-size: #{s};"
  end

  def font_family(f) do
    "font-family: #{f};"
  end

  def line_height(h) do
    "line-height: #{h};"
  end

  # Metrics
  def pct(i), do: "#{i}%"
  def px(i), do: "#{i}px"
  def em(i), do: "#{i}em"

  # Colors
  def hex(h), do: h |> CssColors.parse!()
end
