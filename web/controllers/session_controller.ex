defmodule GameOfCats.SessionController do
  use GameOfCats.Web, :controller

  alias GameOfCats.Session
  alias GameOfCats.Account

  plug :scrub_params, "session" when action in [:create, :update]

  def new(conn, _params) do
    changeset = Session.changeset(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    case authenticate(session_params["name"] || "", session_params["password"]) do
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

  def authenticate(name, password) do
    if (account = Repo.get_by(Account, name: name)) &&
       check_password(account.encrypted_password, gen_password(password)) do
      {:ok, account}
    else
      :error
    end
  end

  def gen_password(password), do: password
  def check_password(password1, password2), do: password1 == password2
end
