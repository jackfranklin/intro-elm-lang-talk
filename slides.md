# Elm

---

@Jack_Franklin
pusher.com
jack@pusher.com

## https://github.com/jackfranklin/intro-elm-lang-talk

---

First release in April 2012.

Latest release, 0.16, in November 2015.

---

# Functional

A heavily Haskell inspired syntax.

(Please don't be put off!)

---

# Types and Immutability

> Types are an important tool for modeling. Think of them like a contract that can be checked by the compiler ... so you can make sure that bad data never gets in. __This is a huge part of how we can rule out runtime errors in Elm.__
-- http://elm-lang.org/guide/model-the-problem

---

# Reactive Programming

> Reactive programming is programming with asynchronous data streams.
-- https://gist.github.com/staltz/868e7e9bc2a7b8c1f754

---

# FRP and Elm

> The FRP aspect greatly simplifies the process of writing graphical interfaces by decoupling the inputs, such as mouse clicks and key presses, from the logic in the program. 

-- http://chrisberragan.com/posts/2015/01/05/general-introduction-to-elm/

---

# Developer Workflow

- `elm package` for installing / publishing packages (SemVer guaranteed!)
- `elm reactor` for running Elm in a browser locally
- (WIP) [elm format](https://github.com/avh4/elm-format) for automatically formatted Elm

---

# Syntax

(Stick with me!)

---

JS: 

```javascript
function add(x, y) {
  return x + y;
}
```

Elm:

```
add x y =
  x + y
```

---

JS: 

```javascript
function add(x, y) {
  return x + y;
}
```

Elm:

```
add : Int -> Int -> Int
add x y =
  x + y
```

---

# Compilers are great

```
add 2 "foo"
```

```
-- TYPE MISMATCH ------------------------------------------------------- App.elm

The 2nd argument to function `add` is causing a mismatch.

12│                                          add 2 "foo"
                                                   ^^^^^
Function `add` is expecting the 2nd argument to be:

    Int

But it is:

    String
```

---

# Elm's compiler is one of its best features.

---

```javascript
function heyName(name) {
  return "Hey " + name;
}
```

```
heyName : String -> String
heyName name =
  "Hey " ++ name
```

---

JS:

```javascript
function doubleNums(nums) {
  return nums.map(function(x) {
    return x * 2;
  });
}
```

Elm:

```
import List

doubleNumbers : List number -> List number
doubleNumbers nums =
  List.map (\x -> x * 2) nums
```

---

> In contrast with Object-Oriented languages, Elm does not have a concept of “methods” where your data and logic are tightly coupled. Instead, functions and data exist separately. 

-- http://elm-lang.org/guide/core-language

---

# Lists in Elm

Like JS arrays, but __each value must be the same type__.

http://package.elm-lang.org/packages/elm-lang/core/3.0.0/List

```
[1..4]
[1, 2, 3, 4]
1 :: [2, 3, 4]
1 :: 2 :: 3 :: 4 :: []
```

---

# Tuples

Fixed number of values, __each value can have any type__.

Use `fst` to access first element, and `snd` for second.

```
doubleCoordinates : (Int, Int) -> (Int, Int)
doubleCoordinates coords =
  ((fst coords) * 2, (snd coords) * 2)
```

---

You can also destructure tuples:

```
doubleCoordinates : (Int, Int) -> (Int, Int)
doubleCoordinates (x, y) =
  (x * 2, y * 2)
```

---

# Records

Set of key value pairs, similar to JS objects.

```
myRecord =
  {
    x = 3,
    y = 4,
    name = "Jack"
  }

myRecord.x == 3
myRecord.name == "Jack"
```

---

Records are immutable, but you can create new records from existing ones:

```
newRecord =
  { myRecord | name = "Bob" }
```

---

# Record Types

```
myRecord : { x : Int, y : Int, name : String }
myRecord =
  { x = 1, y = 2, name = "Jack" }
```

```
type alias Person =
  {
    x : Int,
    y : Int,
    name : String
  }

myRecord : Person
myRecord = 
  { x = 1, y = 2, name = "Jack" }
```

---

# Enumerations

```
type VisibilityFilter = All | Active | Completed

visibilityFilterToString : VisibilityFilter -> String
visibilityFilterToString visibility =
  case visibility of
    All ->
      "All"
    Active ->
      "Active"
    Completed ->
      "Completed"
```

---

You can use enumerations in records as you would expect.

```
type TodoState = NotStarted | InProgress | Complete

type alias Todo =
  {
    state : TodoState,
    title : String
  }
```

---

# Record Types + Enumeration = self documenting, explicit code

---

# Elm Architecture

https://github.com/evancz/elm-architecture-tutorial

---

- `model`
- `update`
- `view`

---

# Model

- a record containg all your application's state

---

# Update

- a function that takes a user action and the model, and returns a new model

---

# View

- a function that takes your application's state and renders it

---

```
-- MODEL

type alias Model = { ... }


-- UPDATE

type Action = Reset | ...

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> ...
    ...


-- VIEW

view : Model -> Html
view =
  ...
```

---

# StartApp

https://github.com/evancz/start-app

Abstracts some of Elm's more complex behaviours away (we'll check them out later).

---

(Taken from Elm Architecture tutorial)

## The model

```
type alias Model = Int
```

## The Actions

```
type Action = Increment | Decrement
```

---

## The `update` function

```
update : Action -> Model -> Model
update action model =
  case action of
    Increment -> model + 1
    Decrement -> model - 1
```

---

## The `view` function

Uses [elm-html](http://elm-lang.org/blog/blazing-fast-html). (Virtual DOM up in here).

```
import Html.Events exposing (onClick)
import Html exposing (button, div, p, text)

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [ ] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]
```

---

## The StartApp wiring

```
import Counter exposing (update, view)
import StartApp.Simple exposing (start)
import Html exposing (Html)

main : Signal Html
main =
  start { model = 0, update = update, view = view }
```

---

# Demo!

---

- `Signal.Address Action`
- `onClick address Decrement`
- `main : Signal Html`

---

# Signals and Reactivity

http://elm-lang.org/guide/reactivity

---

> A signal is a value that changes over time.
-- http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal

---

> We can think of the mouse position as a pair of numbers that is changing over time whenever the user moves the mouse.

---

```
main : Signal Html
```

The `main` function renders some `Html` that changes over time (and is updated automatically for you)

---

# When the value in a signal changes, Elm deals with it automatically for you

---

![fit](https://github.com/evancz/elm-architecture-tutorial/raw/master/diagrams/signal-graph-summary.png)

---

# Mailboxes

```
type alias Mailbox a = 
    { address : Address a
    , signal : Signal a
    }
```

Send messages to an address that are then sent through the signal.

This is what `StartApp` uses to send user actions through our application.

---

# Going StartApp free

If you don't need extra control, you don't necessarily need to to this.

---

```
type Action
  = Increment
  | Decrement
  | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    NoOp ->
      model
```

---

```
actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp
```

---

```

initialModel : Model
initialModel =
  0


model : Signal Model
model =
  Signal.foldp update initialModel actions.signal


main : Signal Html
main =
  Signal.map (view actions.address) model
```

---

# Signal.foldp

---

```
Signal.foldp update initialModel actions.signal
```

> Create a past-dependent signal. Each update from the incoming signals will be used to step the state forward. The outgoing signal represents the current state.

---

# There's so much more!

---

# Tasks & Interopability with Ports

https://blog.pusher.com/making-elm-lang-realtime-with-pusherjs/

---

- awesome-elm: https://github.com/isRuslan/awesome-elm
- these slides & code: https://github.com/jackfranklin/intro-elm-lang-talk
- elm docs: http://elm-lang.org/docs
- Elm weekly: http://www.elmweekly.nl/




