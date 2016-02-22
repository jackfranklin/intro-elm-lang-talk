module Counter (main) where

import Html.Events exposing (onClick)
import Html exposing (..)


type alias Model =
  Int


type Action
  = Increment
  | Decrement
  | NoOp


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    NoOp ->
      model


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]


initialModel : Model
initialModel =
  0


model : Signal Model
model =
  Signal.foldp update initialModel actions.signal


main : Signal Html
main =
  Signal.map (view actions.address) model
