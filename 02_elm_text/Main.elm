import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onInput)
import String

main = beginnerProgram {model = model, view = view, update = update}

type alias Model = {
    content : String
}

model = Model ""

type Msg = Change String


update : Msg -> Model -> Model
update msg model = 
    case msg of
        Change newContent ->  {model | content = newContent}
            
view : Model -> Html Msg
view model = 
    div [] 
    [
      input [ placeholder "Text to reverse", onInput Change] [],
      div [] [text (String.reverse model.content)]
    ]

