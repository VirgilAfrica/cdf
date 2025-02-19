defmodule CdfWeb.ReviewLive.Index do
  use CdfWeb, :live_view

  alias Cdf.Reviews
  alias Cdf.Reviews.Review
  alias Cdf.Targets
  alias Cdf.Targets.Target

  @impl true
  def mount(_params, _session, socket) do
    socket = stream(socket, :reviews, Reviews.list_reviews())

    {:ok, assign(socket, target: %Target{})}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Review")
    |> assign(:review, Reviews.get_review!(id))
  end

  defp apply_action(socket, :add_review, %{"id" => id}) do
    review = Reviews.get_review!(id)
    IO.inspect(review)
    socket
    |> assign(:page_title, "New Review")
    |> assign(:review, %Review{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reviews")
    |> assign(:review, nil)
  end




  @impl true
  def handle_info({CdfWeb.ReviewLive.FormComponent, {:saved, review}}, socket) do
    {:noreply, stream_insert(socket, :reviews, review)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    review = Reviews.get_review!(id)
    {:ok, _} = Reviews.delete_review(review)

    {:noreply, stream_delete(socket, :reviews, review)}
  end
end
