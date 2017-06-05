defmodule OpsInventory.ServerController do
  use OpsInventory.Web, :controller

  alias OpsInventory.Server

  def index(conn, _params) do
    servers = Repo.all(Server)
    render(conn, "index.html", servers: servers)
  end

  def new(conn, _params) do
    changeset = Server.changeset(%Server{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"server" => server_params}) do
    changeset = Server.changeset(%Server{}, server_params)

    case Repo.insert(changeset) do
      {:ok, _server} ->
        conn
        |> put_flash(:info, "Server created successfully.")
        |> redirect(to: server_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Server, id) do
      nil -> 
        conn
        |> put_status(404)
        |> render(OpsInventory.ErrorView, "404.html")
      server -> 
        render(conn, "show.html", server: server)
    end
  end

  def edit(conn, %{"id" => id}) do
    server = Repo.get!(Server, id)
    changeset = Server.changeset(server)
    render(conn, "edit.html", server: server, changeset: changeset)
  end

  def update(conn, %{"id" => id, "server" => server_params}) do
    server = Repo.get!(Server, id)
    changeset = Server.changeset(server, server_params)

    case Repo.update(changeset) do
      {:ok, server} ->
        conn
        |> put_flash(:info, "Server updated successfully.")
        |> redirect(to: server_path(conn, :show, server))
      {:error, changeset} ->
        render(conn, "edit.html", server: server, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Server, id) do
      nil -> 
        conn
        |> put_status(404)
        |> render(OpsInventory.ErrorView, "404.html")
      server ->
        case Repo.delete server do
          {:ok, _} -> 
            conn
            |> put_flash(:info, "Server deleted successfully.")
            |> redirect(to: server_path(conn, :index))
          {:error, _} ->
            conn
            |> put_status(500)
            |> render(OpsInventory.ErrorView, "500.html")
        end
    end
  end
end
