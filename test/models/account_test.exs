defmodule GameOfCats.AccountTest do
  use GameOfCats.ModelCase

  alias GameOfCats.Account

  @valid_attrs %{name: "admin", password: "secret"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
