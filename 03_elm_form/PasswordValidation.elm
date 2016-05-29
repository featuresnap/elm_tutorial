module PasswordValidation exposing (..)

import String exposing (length, toUpper)

validatePassword : String -> Result String String
validatePassword password = 
    if (length password) < 8 then
        Err "Password too short."
    else if password == (toUpper password) then 
        Err "Password must contain lowercase"
    else Ok password 

    