defmodule JpInput.DomainFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JpInput.Domain` context.
  """

  @doc """
  Generate a thing.
  """
  def thing_fixture(attrs \\ %{}) do
    {:ok, thing} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> JpInput.Domain.create_thing()

    thing
  end
end
