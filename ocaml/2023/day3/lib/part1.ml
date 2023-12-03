let sll_to_saa sll = Array.of_list (List.map Array.of_list sll)

let is_digit c = List.exists (fun x -> x = c)  ['1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '0'];;
let is_sybol c = if not (is_digit c || c = '.') then true else false 

let gen_mask ~(f: char list list -> int array array ) (cll : char list list) = f cll

let num_mask =fun c ->
    let open List in
    map (fun x -> map (fun y -> if is_digit y then 1 else 0 ) x  ) c 
    |> sll_to_saa

let sybol_mask =fun c ->
    let open List in
    let bin_map = (map (fun x -> map (fun y ->  if is_sybol y then 1 else 0 ) x  ) c |> sll_to_saa)in

let nomalize_matrix d a x = 
 for i = 1 to d do 
      for j = 1 to d do
          let n = i*j in
          x.(i)(j) <- sprintf "%s_%d" a n
      done
  done;
x;;


       
let  res input = 
    let open List in
    let input = map (fun x -> init (String.length x) (String.get x)) input in
    Array.iter (fun x -> print_newline (); Array.iter print_int x)  (gen_mask  input ~f:num_mask); print_newline ();
    Array.iter (fun x -> print_newline (); Array.iter print_int x)  (gen_mask  input ~f:sybol_mask)
    ; (-1)
