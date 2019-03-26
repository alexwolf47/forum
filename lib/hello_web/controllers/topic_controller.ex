defmodule HelloWeb.TopicController do
  use HelloWeb, :controller
  alias HelloWeb.Topic
  alias HelloWeb.TopicView
  alias HelloWeb.UserAuth

  plug(:auth_session when action in [:new, :create, :edit, :update, :delete])

  ## Plug functions

  def auth_session(conn, _params) do
    if UserAuth.user_signed_in?(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Please sign in to create a topic!")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end

  # def user_signed_in?(conn) do
  #   session_map = conn.private.plug_session
  #   session_map |> Map.has_key?("username") |> IO.inspect(label: "Map has key result")
  # end

  # def get_username(conn) do
  #   conn |> get_session("username")
  # end

  ## Controller functions

  def index(conn, %{"last" => count}) do
    topics = Repo.all(Topic) |> TopicView.last_topics(count)
    render(conn, "index.html", topics: topics)
  end

  def index(conn, %{"order" => sort}) do
    topics =
      case sort do
        "az" -> Repo.all(Topic) |> TopicView.order_by_alphabet()
        "date_new" -> Repo.all(Topic) |> TopicView.order_by_date_new()
        "date_old" -> Repo.all(Topic) |> TopicView.order_by_date_old()
      end

    render(conn, "index.html", topics: topics)
  end

  def index(conn, _params) do
    # Make a test
    # conn |> user_signed_in? |> IO.inspect(label: "Index - User signed in result")

    topics = Repo.all(Topic) |> Enum.sort_by(fn x -> x.id end)
    render(conn, "index.html", topics: topics)
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    conn
    |> render("new.html", changeset: changeset)

    # IO.puts("++++++++")
    # conn |> IO.inspect(label: "10 - Incoming requestion conn")
    # render(conn, "new.html")
  end

  def create(conn, %{"topic" => topic}) do
    username = get_session(conn, :username)

    updated_topic =
      topic
      |> IO.inspect(label: "40")
      |> Map.put("created_by_user", username)
      |> IO.inspect(label: "42")

    changeset = Topic.changeset(%Topic{}, updated_topic)
    changeset |> IO.inspect(label: "46")

    case Repo.insert(changeset) do
      {:ok, _post} ->
        topics = Repo.all(Topic)
        render(conn, "index.html", topics: topics)

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)

    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => updated_topic}) do
    old_topic = Repo.get!(Topic, topic_id)
    changeset = Topic.changeset(old_topic, updated_topic)
    Repo.update(changeset)

    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!()

    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end
end
