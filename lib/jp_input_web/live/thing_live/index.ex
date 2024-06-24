defmodule JpInputWeb.ThingLive.Index do
  use JpInputWeb, :live_view

  alias JpInput.Domain
  alias JpInput.Domain.Thing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :things, Domain.list_things())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thing")
    |> assign(:thing, Domain.get_thing!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thing")
    |> assign(:thing, %Thing{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Things")
    |> assign(:thing, nil)
  end

  @impl true
  def handle_info({JpInputWeb.ThingLive.FormComponent, {:saved, thing}}, socket) do
    {:noreply, stream_insert(socket, :things, thing)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thing = Domain.get_thing!(id)
    {:ok, _} = Domain.delete_thing(thing)

    {:noreply, stream_delete(socket, :things, thing)}
  end
end
