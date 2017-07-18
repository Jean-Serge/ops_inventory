defmodule OpsInventory.Router do
  use OpsInventory.Web, :router

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

  scope "/", OpsInventory do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/servers", ServerController
  end

  # Other scopes may use custom stacks.
  scope "/api", OpsInventory do
    pipe_through :api

    patch "/synchronize_droplets",  DigitalOceanController, :synchronize
  end
end
