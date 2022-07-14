extern crate termion;

use termion::{color, style};
use std::io;

fn main() {
    println!("{}first productive code soon?", color::Fg(color::Red));
}
