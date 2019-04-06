defmodule HelloWeb.CommentController do
  use HelloWeb, :controller

  alias Hello.Topic.Comments
  alias Hello.Topic.Comments.Topic.Comment

  def action(conn, _) do
    conn |> IO.inspect(label: "COnn in action")
    topic = Comments.get_topic!(conn.params["topic_id"])
    topic |> IO.inspect(label: "topic from conn params t id")
    args = [conn, conn.params, topic]
    apply(__MODULE__, action_name(conn), args)
  end

  # # We include the category as the third argument...
  # def index(conn, _params, topic) do
  #   # we pass it to the `list_threads` function
  #   topics = Comments.list_topic_comments(topic)
  #   # and we pass it in our call to render, so templates can refer to it as
  #   # @category.
  #   render(conn, "index.html", topics: topics)
  # end

  def list_comments(topic_id) do
    Comments.list_topic_comments(topic_id)
  end

  def create_changeset(topic_id) do
    comment_changeset = Comment.changeset(%Comment{}, %{topic_id: topic_id})

    comment_changeset

    # comment_changeset =
    #   Comments.change_comment(%Comment{})
    #   |> Map.put(:topic_id, topic.id)
    #   |> IO.inspect(label: "Topic changeset")

    # render(conn, "new.html", comment_changeset: comment_changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    changeset = Comments.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    {:ok, _comment} = Comments.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
