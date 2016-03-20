defmodule GameOfCats.PageController do
  use GameOfCats.Web, :controller
  plug :auth

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def auth(conn, _options) do
    account_id = get_session(conn, :account_id)
    account = account_id && Repo.get(GameOfCats.Account, account_id)

    conn
    |> assign(:current_account, account)
  end
end
