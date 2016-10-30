module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Date
import Time exposing (..)
import Date.Extra.Duration exposing (diff, DeltaRecord, zeroDelta)


type alias Model =
    { time : Time, delta : DeltaRecord }


type Msg
    = Tick Model


initModel : ( Model, Cmd Msg )
initModel =
    ( { time = 0, delta = zeroDelta }, Cmd.none )


diffDates : String -> Time -> DeltaRecord
diffDates date currTime =
    case Date.fromString date of
        Err msg ->
            zeroDelta

        Ok value ->
            diff (Date.fromTime currTime) value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg update =
    case msg of
        Tick newTime ->
            ({ update
                | delta =
                    diffDates
                        "1993-01-01 17:00"
                        newTime.time
             }
                ! []
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every millisecond (\x -> Tick { time = x, delta = zeroDelta })


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ (toString >> text) model.delta ]
        ]


main : Program Never
main =
    App.program
        { init = initModel
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
