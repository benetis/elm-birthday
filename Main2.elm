module Main exposing (..)

import Html exposing (div, button, text)
import Html.App as App
import Html.Events exposing (onClick)
import Task
import Time exposing (Time)


main =
    App.program
        { init = ( Model 0 0, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


view model =
    div []
        [ button [ onClick decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick increment ] [ text "+" ]
        ]


increment =
    GetTimeAndThen (\time -> Increment time)


decrement =
    GetTimeAndThen (\time -> Decrement time)


type Msg
    = Increment Time
    | Decrement Time
    | GetTimeAndThen (Time -> Msg)


type alias Model =
    { count : Int, updateTime : Time }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetTimeAndThen successHandler ->
            ( model, (Task.perform assertNeverHandler successHandler Time.now) )

        Increment time ->
            ( { model | count = model.count + 1, updateTime = time }, Cmd.none )

        Decrement time ->
            ( { model | count = model.count - 1, updateTime = time }, Cmd.none )


assertNeverHandler : a -> b
assertNeverHandler =
    (\_ -> Debug.crash "This should never happen")
