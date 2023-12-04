#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Clone, Copy)]
#[allow(dead_code)]
struct Nums {
    num: usize,
    start: usize,
    end: usize,
}

pub fn res(input: Vec<u8>) -> usize {
    let mut nums: Vec<Nums> = Vec::new();
    let mut tmp_num = Vec::new();
    for (i, c) in input.iter().enumerate() {
        match c {
            b'0'..=b'9' => {
                tmp_num.push(c.clone());
            }
            _ => {
                if !tmp_num.is_empty() {
                    nums.push(Nums {
                        num: String::from_utf8(tmp_num.clone())
                            .unwrap()
                            .parse::<usize>()
                            .unwrap(),
                        start: (i as isize - tmp_num.len() as isize) as usize,
                        end: i - 1,
                    });
                    tmp_num = vec![];
                }
            }
        }
    }

    let new_line_pos = input.iter().position(|&x| x == b'\n').unwrap() as isize;

    //println!("all_nums:\n {:#?}", nums);

    let mut valid_nums = Vec::new();

    for (i, c) in input.iter().enumerate() {
        let i = i as isize;
        let idx_to_cheak: Vec<isize> = vec![
            i - 1,
            i + 1,
            i - new_line_pos,
            i + new_line_pos,
            i - new_line_pos - 1,
            i + new_line_pos + 1,
            i - new_line_pos - 2,
            i + new_line_pos + 2,
        ];
        match c {
            b'0'..=b'9' | b'.' | b'\n' => (),
            _ => {
                for idx in &idx_to_cheak {
                    let idx = *idx as usize;
                    for num in nums.iter() {
                        if (idx >= num.start) && (idx <= num.end) {
                            valid_nums.push(num);
                        }
                    }
                }
            }
        }
    }
    let mut valid_gears_rations: Vec<usize> = Vec::new();
    for (i, c) in input.iter().enumerate() {
        let i = i as isize;
        let idx_to_cheak: Vec<isize> = vec![
            i - 1,
            i + 1,
            i - new_line_pos,
            i + new_line_pos,
            i - new_line_pos - 1,
            i + new_line_pos + 1,
            i - new_line_pos - 2,
            i + new_line_pos + 2,
        ];
        let mut found_gerans: Vec<Nums> = Vec::new();
        match c {
            b'*' => {
                for idx in idx_to_cheak {
                    for num in nums.iter() {
                            let idx = idx as usize;
                            if (idx >= num.start) && (idx <= num.end) {
                                found_gerans.push(num.clone())
                            }
                    }
                }
                found_gerans.dedup();
                if found_gerans.len() == 2 {
                    valid_gears_rations
                        .push(found_gerans.first().unwrap().num * found_gerans.last().unwrap().num)
                }
            }
            _ => (),
        }
    }
    println!(
        "gears {:?}",
        valid_gears_rations.iter().fold(0, |accum, &num| accum as usize + num)
    );
    valid_nums.sort();
    valid_nums.dedup();
    //println!("{:?}", valid_nums);
    valid_nums
        .iter()
        .fold(0, |accum, &num| accum as usize + num.num)
}
