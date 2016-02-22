module Main (..) where

import Counter exposing (update, view)
import StartApp.Simple exposing (start)
import Html exposing (Html)


main : Signal Html
main =
  start
    { model = 0
    , update = update
    , view = view
    }
