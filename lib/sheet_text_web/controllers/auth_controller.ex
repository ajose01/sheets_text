defmodule SheetTextWeb.AuthController do
  use SheetTextWeb, :controller
  alias SheetText.Oauth.Google

  @doc """
  This action is reached via `/auth/callback` is the the callback URL that
  Google's OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code} = params) do
    IO.inspect(params, label: ">>> PARAMS")
    # Exchange an auth code for an access token
    client = Google.get_token!(code: code) |> IO.inspect(label: "client")

    # Request the user's data with the access token
    scope = "https://www.googleapis.com/auth/spreadsheets.readonly"
    %{body: access_scope} = OAuth2.Client.get!(client, scope) |> IO.inspect(label: "scope")
    Jason.decode!(client.token.access_token) |> IO.inspect(label: "JSON DECODE")

    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:access_scope, access_scope)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth` and redirects to the Google OAuth2 provider.
  """
  def index(conn, _params) do
    redirect(conn,
      external:
        Google.authorize_url!(scope: "https://www.googleapis.com/auth/spreadsheets.readonly")
    )
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
