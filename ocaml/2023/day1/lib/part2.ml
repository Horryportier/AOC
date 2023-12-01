(*
scroll over strnig end extract all substring matching stirng with ending pos
*)
let pret f t = Printf.printf f t; t
let get_part s e l = (List.filteri (fun  i _  -> i >= s && i <= e ) l);;
let str_of_char_list s = String.concat "" (List.map (String.make 1) s);;


let numbers  =  [ "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight"; "nine"; "1" ; "2" ; "3" ; "4" ; "5" ; "6" ; "7" ; "8" ; "9" ; "0" ; ]
let map_number x = match x with
    | "one" ->  '1'
    | "two" ->  '2'
    | "three" -> '3'
    | "four" -> '4'
    | "five" -> '5'
    | "six" ->  '6'
    | "seven" -> '7'
    | "eight" -> '8'
    | "nine" -> '9'
    | _ -> String.get x 0

let eq l r =  str_of_char_list l  = str_of_char_list r

let find pattern s = 
    let open List in
    let s = init (String.length s) (String.get s) in
    let s_l = length s in
    let pattern = init (String.length pattern) (String.get pattern) in
    let pattern_l = length pattern in
    let rec scroll offset buff = 
        match offset with
        | o when o > s_l - pattern_l ->  buff
        | _ ->  
        let part = get_part offset (offset + pattern_l - 1)  s in
(*             Printf.printf "%b\n" (eq part pattern); *)
        if eq part pattern then 
            scroll (offset + 1) (((str_of_char_list part) , offset + pattern_l - 1) :: buff)
        else 
            scroll (offset + 1) buff in
    scroll 0 []
        
let pp (w, e) = Printf.printf "w: %s, e: %i" w e

let extract_number s = List.map (fun x -> find x s) numbers
            |> List.concat 
            |>  List.sort (fun (_, v1) (_, v2) -> compare v1 v2 ) 
            |> List.map (fun (w, _) -> map_number w) 


let res i = 
    let open List in
    let splited = String.split_on_char '\n' i in
    map (fun s -> extract_number s ) splited 
    |> map (fun cl -> (nth cl 0) :: (nth cl (length cl -1)) :: [] ) 
    |> map (fun n  ->  str_of_char_list n |> int_of_string) 
    |> fold_left (+) 0
