module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (onInput)
import PasswordValidation exposing (..)



main =   
    App.beginnerProgram {model = model, update = update, view = view}

type alias Model = {
    name : String,
    password : String,
    passwordAgain : String
}

type Msg 
    = Name String
    | Password String
    | PasswordAgain String

model : Model
model = 
    Model "" "" ""

update : Msg -> Model -> Model
update action model = 
    case action of 
    Name name -> {model | name = name}
    Password password -> {model | password = password}
    PasswordAgain password -> {model | passwordAgain = password}
    
view : Model -> Html Msg
view model = 
    div [] 
    [
        input [type' "text", placeholder "Name", onInput Name] [],
        input [type' "text", placeholder "Password", onInput Password] [],
        input [type' "text", placeholder "Re-Enter Password", onInput PasswordAgain] [],
        viewValidation model,
        passwordValidation model
    ] 

viewValidation : Model -> Html Msg
viewValidation model = 
    let (color, message) = 
        if model.password == model.passwordAgain then
            ("green", "OK")
        else
            ("red", "Passwords do not match")
    in 
    div [ style [("color", color)]] [ text message ]
    
passwordValidation : Model -> Html Msg
passwordValidation model = 
    let (color, message) = 
        case (validate model.password) of 
        Result.Ok pwd -> ("green", "OK")
        Result.Err msgs -> ("red", "Some problem")
    in
    div [style [("color", color)]] [text message]