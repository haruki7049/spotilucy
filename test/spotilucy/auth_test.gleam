import gleam/result
import gleam/uri
import gleeunit/should
import spotilucy/auth

pub fn build_auth_url_test() {
  let client_id = "abc123"
  let redirect_uri = "https://myapp.com/callback"
  let scopes = ["user-read-email", "playlist-read-private"]

  let url = auth.build_auth_url(client_id, redirect_uri, scopes)

  // 期待するURL（順序やエンコーディングに注意）
  let expected =
    uri.parse(
      "https://accounts.spotify.com/authorize?client_id=abc123&response_type=code&redirect_uri=https%3A%2F%2Fmyapp.com%2Fcallback&scope=user-read-email%20playlist-read-private",
    )
    |> result.map_error(fn(_) { auth.ParseUriError })

  should.equal(url, expected)
}
