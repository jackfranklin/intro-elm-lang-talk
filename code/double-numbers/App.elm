module App (..) where

import Graphics.Element exposing (show)
import List


doubleNumbers : List number -> List number
doubleNumbers nums =
  List.map (\x -> x * 2) nums


main =
  show (doubleNumbers [ 1, 2, 3 ])
