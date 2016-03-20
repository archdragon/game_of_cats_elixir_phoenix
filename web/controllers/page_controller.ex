defmodule GameOfCats.PageController do
  use GameOfCats.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
