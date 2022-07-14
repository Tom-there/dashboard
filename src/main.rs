use termion::{color, style};
use std::io;

fn main() {
    println!("{}{}Stuff", termion::clear::All, termion::cursor::Goto(2, 1));
}
