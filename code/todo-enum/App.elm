module App (..) where

import Graphics.Element exposing (show)


type TodoState
  = NotStarted
  | InProgress
  | Complete


type alias Todo =
  { state : TodoState
  , title : String
  }


showTodo : Todo -> String
showTodo todo =
  (toString todo.state) ++ " : " ++ todo.title


main =
  let
    todo =
      { state = InProgress, title = "Do this Elm talk" }
  in
    show (showTodo todo)
