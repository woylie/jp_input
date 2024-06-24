# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JpInput.Repo.insert!(%JpInput.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

JpInput.Repo.insert!(%JpInput.Domain.Thing{description: """
  で
  で
  """})
