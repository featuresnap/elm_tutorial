module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (onInput)
import Util.PasswordValidation exposing (..)

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
        passwordMatchValidation model,
        passwordContentValidation model
    ] 

passwordMatchValidation : Model -> Html Msg
passwordMatchValidation model = 
    let (color, message) = 
        if model.password == model.passwordAgain then
            ("green", "OK")
        else
            ("red", "Passwords do not match")
    in 
    div [ style [("color", color)]] [ text message ]
    
passwordContentValidation : Model -> Html Msg
passwordContentValidation model = 
    let 
        contentResults = validate model.password
        color = case contentResults of 
            Ok _ -> "green"
            _ -> "red"
        msgs = case contentResults of
            Ok _ -> 
            [
                p [] [text "OK"]
            ]
            Err errors -> 
                errors |> List.map (\msg -> p [] [text msg])
    in
    div [style [("color", color)]] msgs