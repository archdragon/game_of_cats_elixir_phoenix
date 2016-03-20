defmodule GameOfCats.SessionController do
  use GameOfCats.Web, :controller
  alias GameOfCats.Account
  alias GameOfCats.Auth

  plug :scrub_params, "account" when action in [:create, :update]

  def new(conn, _params) do
    account = Account.changeset(%Account{})
    render(conn, "new.html", account: account)
  end

  def create(conn, %{"account" => account_params}) do
    case Auth.authenticate(account_params["name"] || "", account_params["password"]) do
      {:ok, %Account{id: id}} ->
        conn
        |> put_session(:account_id, id)
        |> put_flash(:info, "Session OK")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Session invalid")
        |> redirect(to: "/")
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: session_path(conn, :index))
  end
end
