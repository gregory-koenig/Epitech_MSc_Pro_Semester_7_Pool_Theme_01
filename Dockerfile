# # ./Dockerfile

# # Extend from the official Elixir image
# FROM elixir:latest

# # Create app directory and copy the Elixir projects into it
# RUN mkdir /app
# COPY . /app
# WORKDIR /app

# # Install hex package manager
# # By using --force, we don’t need to type “Y” to confirm the installation
# RUN mix local.hex --force && \
#     mix archive.install hex phx_new 1.5.3 --force && \
#     mix local.rebar --force
# RUN mix deps.clean --all
# RUN mix deps.get
# RUN mix ecto.create
# RUN mix phx.server

# # Compile the project
# #RUN mix do compile
# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app


# Install hex package manager
# RUN mix local.hex --force
RUN mix local.hex --force && \
    mix archive.install hex phx_new 1.5.3 --force && \
    mix local.rebar --force
RUN mix deps.get
# Compile the project
# RUN mix deps.compile phoenix_live_dashboard
RUN mix do compile
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

