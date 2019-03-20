defmodule CssTest do
  use ExUnit.Case
  
  import Css
  doctest Css

  test "hover" do
    styles = [
      display_flex(),
      hover [background_color %CssColors.RGB{red: 32, green: 15, blue: 19}]
    ]

    {class, output} = styled(styles)
    
    assert class == "aoGhYVFwgcTVVW"
    assert output == ".aoGhYVFwgcTVVW {\n  display: flex;\n}\n.aoGhYVFwgcTVVW:hover {\n  background-color: #200F13;\n}\n"
  end

  test "styled" do
    styles = [background_color %CssColors.RGB{red: 32, green: 15, blue: 19}]
    {class, output} = styled(styles)

    assert class == "FRVezCvCMuQPN"
    assert output == ".FRVezCvCMuQPN {\n  background-color: #200F13;\n}\n"
  end

  test "rgb" do
    assert rgb("#200F13") == %CssColors.RGB{alpha: 1.0, blue: 19.0, green: 15.0, red: 32.0}
  end

  test "background_color" do
    assert background_color(%CssColors.RGB{red: 32, green: 15, blue: 19}) == "background-color: #200F13;"
  end

  test "color" do
    assert color(%CssColors.RGB{red: 32, green: 15, blue: 19}) == "color: #200F13;"
  end

  test "display_flex" do
    assert display_flex() == "display: flex;"
  end

  test "flex" do
    assert flex(3) == "flex: 3;"
  end

  test "flex_direction" do
    assert flex_direction("column") == "flex-direction: column;"
  end

  test "width" do
    assert width(100 |> pct) == "width: 100%;"
  end

  test "margin" do
    assert margin(0) == "margin: 0;"
  end

  test "padding/2" do
    assert padding(10 |> px, 5 |> px) == "padding: 10px 5px;"
  end

  test "border/3" do
    assert border(1 |> px, "solid", "#bbc0c4" |> CssColors.parse!()) == "border: 1px solid #BBC0C4;"
  end

  test "border_top_color" do
    assert border_top_color("#bbc0c4" |> CssColors.parse!()) == "border-top-color: #BBC0C4;"
  end

  test "border_left_color" do
    assert border_left_color("#bbc0c4" |> CssColors.parse!()) == "border-left-color: #BBC0C4;"
  end

  test "border_bottom_color" do
    assert border_bottom_color("#bbc0c4" |> CssColors.parse!()) == "border-bottom-color: #BBC0C4;"
  end

  test "border_right_color" do
    assert border_right_color("#bbc0c4" |> CssColors.parse!()) == "border-right-color: #BBC0C4;"
  end

  test "border_color" do
    assert border_color("#bbc0c4" |> CssColors.parse!()) == "border-color: #BBC0C4;"
  end

  test "border_radius" do
    assert border_radius(3 |> px) == "border-radius: 3px;"
  end

  test "box_shadow/4" do
    assert box_shadow(0, 0, 0, rgb("#FFF")) == "box-shadow: 0 0 0 #FFFFFF;"
  end

  test "box_shadow" do
    assert box_shadow("none") == "box-shadow: none;"
  end

  test "font_size" do
    assert font_size(15 |> px) == "font-size: 15px;"
  end

  test "font_family" do
    assert font_family("inherit") == "font-family: inherit;"
  end

  test "line_height" do
    assert line_height(1.15384615) == "line-height: 1.15384615;"
  end
end
