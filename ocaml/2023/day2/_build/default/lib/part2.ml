(*
this function splits cubes into their colors sorts them and,
retrns last (biggest) of each one as list
*)
let find_max cubes  =
    let open List in
    let open Part1 in
    let  msort l = sort (fun a b -> if a < b then -1 else if a > b then 1 else 0 ) l in
    let red = msort (filter_map (fun x -> match x with | Red x-> Some  x | _ -> None)  cubes) in
    let green = msort (filter_map (fun x -> match x with | Green x-> Some  x | _ -> None)  cubes) in
    let blue = msort (filter_map (fun x -> match x with | Blue x-> Some  x | _ -> None)  cubes) in
    let last l = nth l (length l-1) in
    last red :: last green :: last blue :: []

(* 

   *)
let res input =     
    let open Part1 in
    let open List in
    let games =  map t_of_string  input in
    map (fun x ->  (find_max x.cubes) ) games |>
    map (fold_left Int.mul 1) |>
    fold_left (+) 0 
