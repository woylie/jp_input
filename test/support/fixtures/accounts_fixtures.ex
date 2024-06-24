defmodule JpInput.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JpInput.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> JpInput.Accounts.create_user()

    user
  end
end
