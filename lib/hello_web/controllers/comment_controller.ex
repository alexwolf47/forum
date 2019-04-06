defmodule HelloWeb.CommentController do
  use HelloWeb, :controller

  alias Hello.Topic.Comment

  def action(conn, _) do
    # conn |> IO.inspect(label: "COnn in action")
    topic = Comment.get_topic!(conn.params["topic_id"])
    # topic |> IO.inspect(label: "topic from conn params t id")
    args = [conn, conn.params, topic]
    apply(__MODULE__, action_name(conn), args)
  end

  def list_comments(topic_id) do
    Comment.list_topic_comments(topic_id)
  end

  def create_changeset(topic_id) do
    Comment.changeset(%Comment{}, %{topic_id: topic_id})
  end

  def create(conn, %{"comment" => comment_params}, topic) do

    user_id = get_session(conn, :current_user_id)
    updated_comment_params = comment_params |> Map.put("topic_id", topic.id) |> Map.put("user_id", user_id)


    IO.puts "BEGININNG TO CREATE COMMENT"
    case Comment.create_comment(updated_comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   comment = Comment.get_comment!(id)
  #   render(conn, "show.html", comment: comment)
  # end

  # def edit(conn, %{"id" => id}) do
  #   comment = Comment.get_comment!(id)
  #   changeset = Comments.change_comment(comment)
  #   render(conn, "edit.html", comment: comment, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "comment" => comment_params}) do
  #   comment = Comment.get_comment!(id)

  #   case Comment.update_comment(comment, comment_params) do
  #     {:ok, comment} ->
  #       conn
  #       |> put_flash(:info, "Comment updated successfully.")
  #       |> redirect(to: Routes.comment_path(conn, :show, comment))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", comment: comment, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   comment = Comments.get_comment!(id)
  #   {:ok, _comment} = Comments.delete_comment(comment)

  #   conn
  #   |> put_flash(:info, "Comment deleted successfully.")
  #   |> redirect(to: Routes.comment_path(conn, :index))
  # end
end
