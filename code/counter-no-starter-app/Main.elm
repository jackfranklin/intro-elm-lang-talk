module Main (..) where

import Counter
import Html exposing (Html)


main : Signal Html
main =
  Counter.main
