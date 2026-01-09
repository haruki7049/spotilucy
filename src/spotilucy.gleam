import argv
import clip
import clip/help
import gleam/io

pub fn main() -> Nil {
  let result =
    clip.command1()
    |> clip.help(help.simple(
      "spotilucy",
      "A TUI spotify client written by Gleam-lang",
    ))
    |> clip.run(argv.load().arguments)

  case result {
    Error(e) -> io.println_error(e)
    Ok(_) -> Nil
  }
}
