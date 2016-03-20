defmodule GameOfCats.Account do
  use GameOfCats.Web, :model
  alias GameOfCats.Auth

  schema "accounts" do
    field :name, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    timestamps
  end

  def create(params) do
    changeset(%GameOfCats.Account{}, params)
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name password), ~w())
    |> validate_length(:password, min: 4, max: 32)
    |> unique_constraint(:name)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    encrypted_password = get_change(changeset, :password) |> Auth.encrypt_password

    changeset
    |> put_change(:encrypted_password, encrypted_password)
  end
end
