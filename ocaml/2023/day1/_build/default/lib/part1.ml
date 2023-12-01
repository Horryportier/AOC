let digits = '1' :: '2' :: '3' :: '4' :: '5' :: '6' :: '7' :: '8' :: '9' :: '0' :: [];;
let res i = 
    let open List in
    let splited = String.split_on_char '\n' i in
    map (fun s -> 
        filter 
                (fun c ->  exists (fun d -> d == c) digits ) 
                (init
                    (String.length s) (String.get s))) splited  
    |> map ( fun x -> (nth x 0) :: (nth x (length x - 1))   :: []) |> 
    map (fun d -> String.concat "" ( List.map (String.make 1) d ) 
    |> int_of_string) 
    |> fold_left (+) 0
        

