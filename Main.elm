module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Date
import Time exposing (..)


type alias Model =
    Time


type Msg
    = Tick Model


initModel : ( Model, Cmd Msg )
initModel =
    ( 0, Cmd.none )


dateStringToTime : String -> Time
dateStringToTime date =
    case Date.fromString date of
        Err msg ->
            1477152604310

        Ok value ->
            Date.toTime value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg update =
    case msg of
        Tick newTime ->
            ( dateStringToTime "1993-01-01 17:00"
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ (Date.fromTime >> toString >> text) model ]
        ]


main : Program Never
main =
    App.program
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
