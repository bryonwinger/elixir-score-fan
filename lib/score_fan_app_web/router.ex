defmodule ScoreFanWeb.Router do
  use ScoreFanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScoreFanWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/sign_in", UserController, :sign_in_new
    post "/sign_in", UserController, :sign_in
    get "/register", UserController, :register_new
    get "/register/confirm/:identity_token", UserController, :confirm_registration
    post "/register", UserController, :register
    delete "/sign_out", UserController, :sign_out
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScoreFanWeb do
  #   pipe_through :api
  # end
end
