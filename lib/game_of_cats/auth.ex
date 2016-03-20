defmodule GameOfCats.Auth do
  alias GameOfCats.{Repo, Account}

  defmodule CurrentAccount do
    import Plug.Conn, only: [get_session: 2, assign: 3]

    def init(options), do: options

    def call(conn, _options) do
      account_id = get_session(conn, :account_id)
      account = account_id && Repo.get(GameOfCats.Account, account_id)

      conn
      |> assign(:current_account, account)
    end
  end

  def authenticate(name, password) do
    if (account = Repo.get_by(Account, name: name)) &&
       check_password(account.encrypted_password, password) do
      {:ok, account}
    else
      :error
    end
  end

  # FIXME: use bcrypt
  def encrypt_password(password) do
    password
  end

  def check_password(encrypted_password, plain_password) do
    encrypted_password == encrypt_password(plain_password)
  end
end
