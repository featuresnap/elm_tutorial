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
    
minimumLength : Rule
minimumLength password = 
    if (length password) < 8 then Err "Password must be at least 8 characters."
    else Ok password
    
containsLower : Rule
containsLower password = 
    if password == (toUpper password) then Err "Password must contain a lowercase character."
    else Ok password

containsUpper : Rule
containsUpper password = 
    if password == (toLower password) then Err "Password must contain an uppercase character." 
    else Ok password
    
containsDigit : Rule 
containsDigit password = 
    if not <| Regex.contains (regex "\\d") password then Err "Password must contain at least one number."
    else Ok password
    
ruleReducer : RuleResult -> RulesResult -> RulesResult
ruleReducer currentResult previousResults = 
    case (currentResult, previousResults) of 
    (Err msg, Ok password) -> Err [msg]
    (Err msg, Err msgs) -> Err (msg :: msgs)
    (Ok password, _) -> previousResults

validate : String -> RulesResult
validate password = 
    let allRules = [minimumLength, containsLower, containsUpper, containsDigit] in
    allRules 
    |> List.map (\rule -> rule password)
    |> List.foldl ruleReducer (Ok password)
    


    

    