defmodule Css.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Css.Cache, %{}}
    ]

    opts = [strategy: :one_for_one, name: Css.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
