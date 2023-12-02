open Day2

let input =  String.split_on_char '\n' ( String.trim  (Core.In_channel.read_all "input"));;


let () = print_int (Part1.res input (12, 13, 14)); 
         print_newline ();
         print_int (Part2.res input)
