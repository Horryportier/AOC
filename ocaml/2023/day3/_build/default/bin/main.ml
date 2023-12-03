open Day3

let input =  String.split_on_char '\n' ( String.trim  (Core.In_channel.read_all "input_small"));;

let () = print_endline "DAY3:"; 
    print_int (Part1.res input); print_newline ();
    print_int (Part2.res input); print_newline ();

