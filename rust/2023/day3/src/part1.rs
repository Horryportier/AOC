pub fn res(input: Vec<u8>) -> usize {
    let mut num_map: Vec<usize> = [].into();
    for c in input.iter() {
        match c {
            b'\n' => num_map.push(2),
            b'.' => num_map.push(0),
            b'0'..=b'9' => num_map.push(1),
            _ => num_map.push(0),
        }
    }
    let mut symbol_map: Vec<usize> = [].into();
    for c in input.iter() {
        match c {
            b'\n' => symbol_map.push(2),
            b'.' => symbol_map.push(0),
            b'0'..=b'9' => symbol_map.push(0),
            _ => symbol_map.push(1),
        }
    }

    let mut line_len = 0;
    for (i, t) in symbol_map.iter().enumerate() {
        if *t == 2 {
            line_len = i;
            break;
        }
    }

    let mut revesed_symbol_map: Vec<usize> = vec![0; symbol_map.len()];
    for (i, b) in symbol_map.iter().enumerate() {
        let i = i as isize;
        let line_len = line_len as isize;
        let itc: [isize; 8] = [
            i - 1,
            i + 1,
            i - line_len,
            i - line_len - 1,
            i - line_len - 2,
            i + line_len,
            i + line_len + 1,
            i + line_len + 2,
        ];
        if *b == 1 {
            for idx in itc.into_iter() {
                if !(idx as usize > symbol_map.len() - 1) {
                    revesed_symbol_map[idx as usize] = 1
                }
            }
        } else if *b == 2 {
            revesed_symbol_map[i as usize] = 2
        }
    }

    let pp = |x: Vec<usize>| {
        x.iter().for_each(|x| {
            if *x == 2 {
                println!("")
            } else {
                print!("{}", x)
            }
        })
    };
    println!("symbol area");
    pp(revesed_symbol_map.clone());
    println!("nums");
    pp(num_map.clone());

    let found = num_map
        .iter()
        .enumerate()
        .map(|(i, x)| match (x, revesed_symbol_map[i]) {
            (0, 0) => 0,
            (1, 0) => 0,
            (0, 1) => 0,
            (1, 1) => 1,
            (2, 2) => 2,
            (_, _) => 0,
        })
        .collect::<Vec<usize>>();

    let mut nums: Vec<String> = Vec::new();
    println!("found nums");
    let mut visited: Vec<usize> = vec![0; input.len()];
    for (i, f) in found.iter().enumerate() {
        let mut curr_visited = false; 
        let i = i as isize;
        if *f == 1 {
        //walk left
        let mut left_idx = 0;
        let mut left: Vec<u8> = Vec::new();
        let mut lb = true;
        while  lb {
            let of_idx = (i - left_idx) as usize;
            match num_map.get(of_idx) {
                    Some(x) =>  match (x, visited[of_idx] ) {
                        (1, 0) => {left.push(input[of_idx]); left_idx +=1; visited[of_idx] = 1; },
                        (1, 1) => {lb = false;  curr_visited = true},
                        _ => lb = false
                    }
                    None => lb = false
                }
        }
        left.reverse();
        

        //walk right
        let mut right_idx = 1;
        let mut right: Vec<u8> = Vec::new();
        let mut rb = true;
        while  rb {
            let of_idx = (i + right_idx) as usize;
            match num_map.get(of_idx) {
                    Some(x) =>  match (x, visited[of_idx]) {
                        (1,0) => {right.push(input[of_idx]); right_idx +=1; visited[of_idx] = 1},
                        (1,1) => {rb = true; curr_visited = true},
                        _ => rb = false
                    }
                    None => rb = false
                }
        }
        left.append(&mut right);

            if !curr_visited  {
        nums.push(String::from_utf8(left).unwrap());
            }
        }
    }
    pp(found);
    println!("nums {:?}", nums);

    return usize::MAX;
}
