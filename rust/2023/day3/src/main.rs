use std::fs;

mod part1;

fn main() {
    let input = fs::read("input_small").unwrap();
    println!("res: {}", part1::res(input))
}   
