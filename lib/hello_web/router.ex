defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HelloWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    get("/session", SessionController, :index)
    post("/session", SessionController, :create)
    get("/session/delete", SessionController, :delete)

    resources("/signin", LoginController, only: [:new, :create])
    delete("/sign-out", LoginController, :delete)

    resources("/register", RegistrationController, only: [:new, :create])

    resources("/users", UserController)

    # get("/topics", TopicController, :index)
    # get("/topics/new", TopicController, :new)
    # post("/topics/new", TopicController, :create)
    # get("/topics/:id", TopicController, :show)
    # get("/topics/:id/edit", TopicController, :edit)
    # put("/topics/:id/edit", TopicController, :update)
    # delete("/topics/:id", TopicController, :delete)

    resources("/topics", TopicController) do
      resources("/comments", CommentController)
    end

    # Other scopes may use custom stacks.
    # scope "/api", HelloWeb do
    #   pipe_through :api
  end
end
