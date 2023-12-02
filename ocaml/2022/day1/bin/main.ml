let file = 
        let ch = open_in_bin  "input.txt" in
        let s = really_input_string ch (in_channel_length ch) in
        close_in ch;
        s

let res f = 
        let splited = String.split_on_char  '\n' f in
        let es =ref [] in
        let e = ref [] in
        for i = 0 to List.length splited do 
                try int_of_string (List.nth splited i) with  
                        | Failure -> es :: !e 
        done
