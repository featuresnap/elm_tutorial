module PasswordValidation exposing (..)

import String exposing (length, toUpper, toLower)
import Regex exposing (regex)

type alias RuleResult = Result String String
type alias RulesResult = Result (List String) String 
type alias Rule = String -> RuleResult

validatePassword : String -> Result String String
validatePassword password = 
    if (length password) < 8 then
        Err "Password too short."
    else if password == (toUpper password) then 
        Err "Password must contain lowercase"
    else Ok password 
    
validateLength : Rule
validateLength password = 
    if (length password) < 8 then Err "Password must be at least 8 characters."
    else Ok password
    
validateLower : Rule
validateLower password = 
    if password == (toUpper password) then Err "Password must contain a lowercase character."
    else Ok password

validateUpper : Rule
validateUpper password = 
    if password == (toLower password) then Err "Password must contain an uppercase character." 
    else Ok password
    
validateNumber : Rule 
validateNumber password = 
    if not <| Regex.contains (regex "\\d") password then Err "Password must contain at least one number."
    else Ok password
    
ruleReducer : RuleResult -> RulesResult -> RulesResult
ruleReducer nextResult currentResults= 
    case (currentResults, nextResult) of 
    (_, Ok password) -> currentResults
    (Ok password, Err msg) -> Err [msg]
    (Err msgs, Err msg) -> Err (msg :: msgs)

allRules : List Rule
allRules = [validateLength, validateLower, validateUpper, validateNumber]

validate : String -> List Rule -> RulesResult
validate password rules = 
    rules 
    |> List.map (\rule -> rule password)
    |> List.foldl ruleReducer (Ok password)
    


    

    