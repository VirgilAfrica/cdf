defmodule CdfWeb.TargetLive.Show do
  use CdfWeb, :live_view
  alias Cdf.Repo
  alias Cdf.Targets
  alias Cdf.Reviews.Review
  import Ecto.Query

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    target = Targets.get_target!(id) # Fetch the target

    case target do
      nil ->
        {:noreply,
        socket
        |> assign(:target, nil)
        |> assign(:reviews, [])}
      target ->
        reviews = show_reviews_for_a_target(%{"target_id" => target.id})
        {:noreply,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:target, target)
         |> assign(:reviews, reviews)}
        end
  end

  def show_reviews_for_a_target(%{"target_id" => target_id}) do
    from(r in Review,
      where: r.target_id == ^target_id,
      select: r) |> Repo.all()
  end

  defp page_title(:show), do: "Show Target"
  defp page_title(:edit), do: "Edit Target"
end
