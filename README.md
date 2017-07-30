[![Code Climate](https://codeclimate.com/github/Jean-Serge/ops_inventory.png)](https://codeclimate.com/github/Jean-Serge/ops_inventory)
[![Issue Count](https://codeclimate.com/github/Jean-Serge/ops_inventory/badges/issue_count.svg)](https://codeclimate.com/github/Jean-Serge/ops_inventory)

# OpsInventory

## Configuration

### Database

You need a PostgreSQL database to run this application. You can use the **docker-compose.yml** file of this repo to create your database.

Start by install _docker_ and _docker-compose_ for your platform, then run `docker-compose up -d`, it will create database for _dev_ and _test_ environment.

Note : If you only want a _dev_ database, you can run `docker-compose up -d ops-inventory-dev`.

### Application

Complete the file **config/dev.exs** with your database credentials.

Note : If you created your database using _docker_, you can skip this step.

Then copy and fill the file **config/dev.secret.exs.example** to **config/dev.secret.exs**.

## Run

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
