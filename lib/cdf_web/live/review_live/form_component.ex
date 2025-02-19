defmodule CdfWeb.ReviewLive.FormComponent do
  use CdfWeb, :live_component

  alias Cdf.Reviews

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage review records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="review-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:date_added]} type="date" label="Date added" />
        <.input field={@form[:percentage_set]} type="number" label="Percentage set" />
        <.input field={@form[:target_id]} type="number" label="Target ID" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Review</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{review: review} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Reviews.change_review(review))
     end)}
  end

  @impl true
  def handle_event("validate", %{"review" => review_params}, socket) do
    changeset = Reviews.change_review(socket.assigns.review, review_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"review" => review_params}, socket) do
    save_review(socket, socket.assigns.action, review_params)
  end

  defp save_review(socket, :edit, review_params) do
    case Reviews.update_review(socket.assigns.review, review_params) do
      {:ok, review} ->
        notify_parent({:saved, review})

        {:noreply,
         socket
         |> put_flash(:info, "Review updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end



  defp save_review(socket, :add_review, review_params) do
    case Reviews.create_review(review_params) do
      {:ok, review} ->
        notify_parent({:saved, review})

        {:noreply,
         socket
         |> put_flash(:info, "Review created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
