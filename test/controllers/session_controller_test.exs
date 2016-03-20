defmodule GameOfCats.SessionControllerTest do
  use GameOfCats.ConnCase
  alias GameOfCats.Account

  test "renders new session page", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "New session"
  end

  test "signs in with valid data" do
    Account.create(%{name: "admin", password: "secret"}) |> Repo.insert!

    params = %{account: %{name: "admin", password: "secret"}}
    conn = post conn, session_path(conn, :create), params
    assert conn.status == 302

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Session OK"
  end

  test "signs in with invalid data" do
    params = %{account: %{name: "", password: ""}}
    conn = post conn, session_path(conn, :create), params
    assert conn.status == 302

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Session invalid"
  end
end
