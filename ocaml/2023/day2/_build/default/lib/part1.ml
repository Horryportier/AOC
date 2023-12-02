exception Err of string

type cube =
| Red of int
| Green of int
| Blue of int


let cube_of_string i = function
| "red" -> Red i
| "green" -> Green i
| "blue" ->  Blue i
| _ as x -> raise (Err ("incorrect color" ^ x))

let to_cube s =
       let i, cube = s in
       cube_of_string (int_of_string i) cube

type t = {
    id: int;
    cubes: cube list; 
}
(*just for debug*)
let pp t =
    let open Printf in
    let cts c = match c with
    | Red x -> "red " ^ (string_of_int x )
    | Green x -> "green " ^ (string_of_int x )
    | Blue x -> "blue " ^ (string_of_int x ) in
    printf "id: %i\n" t.id; 
    printf "pulls: [\n"; 
    List.iter (fun x -> printf "\t%s" (cts x)) t.cubes;
    printf "]\n";;
let t id cubes = {id; cubes}


let rec find_num l = 
    match l with
    | a :: _ when int_of_string_opt (String.trim a)  |> Option.is_some ->  int_of_string a
    | a :: tl when int_of_string_opt (String.trim a)  |> Option.is_none ->  find_num tl
    | _ -> -1

(*
parses lines to t <game> record
*)
let t_of_string s =
         let open String in 
         let open List in
         let id, pulls =
            match split_on_char ':' s with
            | a :: [] -> find_num (split_on_char ' ' a), "None"
            | [] -> -1, "None"
            | a :: b :: _ ->  find_num (split_on_char ' ' a) , b  in
        let cubes =  
        (split_on_char ';' pulls) 
        |> map (split_on_char ',') 
        |> map (fun x ->  
            map 
            (fun y -> let sp 
                = split_on_char ' '
                    y in cube_of_string 
                    (nth sp 1 |> int_of_string) (nth sp 2) ) x) 
        |> concat in
    {id; cubes}

(*
cheaks if any of red green or blue is bigger than max and returns bool
*)
let is_game_valid (r, g, b) game_cubes = 
          let open List in
          match map (fun  x -> match x with
                | Red x -> x <= r
                | Green x -> x <= g
                | Blue x -> x <= b) game_cubes |> find_opt (fun  x -> x = false ) with
          | Some _ -> false 
          | None -> true
    
(*            
validets and sums games
              *)
let res input (r, g, b) =  
    let open List in
    let games =  map t_of_string  input in
    let valid = filter (fun x -> is_game_valid (r, g, b) x.cubes) games in
    map (fun x -> x.id ) valid |> fold_left (+) 0
        
