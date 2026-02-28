import gleam/bool
import gleam/option.{Some}
import gleam/result
import gleam/string
import gleam/uri.{type Uri, Uri}

pub fn build_auth_url(
  client_id: String,
  redirect_uri: String,
  scopes: List(String),
) -> Result(Uri, AuthUrlError) {
  // Guards
  use <- bool.guard(
    client_id |> string.is_empty,
    Error(MissingParameterError("client_id")),
  )
  use <- bool.guard(
    redirect_uri |> string.is_empty,
    Error(MissingParameterError("redirect_uri")),
  )

  let scopes_str = scopes |> string.join(" ")
  let query_params = [
    #("client_id", client_id),
    #("response_type", "code"),
    #("redirect_uri", redirect_uri),
    #("scope", scopes_str),
  ]

  let query_string =
    query_params
    |> uri.query_to_string()

  uri.parse("https://accounts.spotify.com/authorize")
  |> result.map_error(fn(_) { ParseUriError })
  |> result.map(fn(uri) {
    Uri(
      scheme: uri.scheme,
      userinfo: uri.userinfo,
      host: uri.host,
      port: uri.port,
      path: uri.path,
      query: Some(query_string),
      fragment: uri.fragment,
    )
  })
}

pub type AuthUrlError {
  ParseUriError
  MissingParameterError(String)
}
