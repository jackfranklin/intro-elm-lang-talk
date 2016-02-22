module App (..) where

import Graphics.Element exposing (show)


add : Int -> Int -> Int
add x y =
  x + y


main =
  show ("Two plus Two is " ++ (toString (add 2 "foo")))
