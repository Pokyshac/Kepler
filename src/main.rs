#![allow(unused_variables, unused_imports, dead_code, unused_must_use)]

use std::collections::HashMap;
use std::iter::Map;

use high_precision_arithmetics::mult_e::mult_e;
use high_precision_arithmetics::sort_by_abs::sort_by_abs;
use high_precision_arithmetics::two_sum;
use high_precision_arithmetics::vec_sum::vec_sum_err_branch;
use high_precision_arithmetics::vec_sum;
use high_precision_arithmetics::dekker;
use high_precision_arithmetics::veltkamp;
use high_precision_arithmetics::seq_sqrt::seq_sqrt;

use glam::Vec2;

mod high_precision_arithmetics;

fn main() {
}

fn two_bodies_problem<'a>(m1: f64, m2: f64, g: f64,
    t_start: f64,
    steps_count: usize,
    t_end: f64,
    b1_start: Vec2, 
    b2_start: Vec2,
    b1_start_vel: Vec2,
    b2_start_vel: Vec2
) -> HashMap<&'a str, Vec<f64>> {
    let step = (t_end - t_start) / steps_count as f64;    
    
    let mut result = HashMap::<&'a str, Vec<f64>>::with_capacity(8);
    result.insert("a", Vec::<f64>::with_capacity(steps_count));
    result.insert("b", Vec::<f64>::with_capacity(steps_count));
    result.insert("c", Vec::<f64>::with_capacity(steps_count));
    result.insert("d", Vec::<f64>::with_capacity(steps_count));
    result.insert("x1", Vec::<f64>::with_capacity(steps_count));
    result.insert("y1", Vec::<f64>::with_capacity(steps_count));
    result.insert("x2", Vec::<f64>::with_capacity(steps_count));
    result.insert("y2", Vec::<f64>::with_capacity(steps_count));

    for i in 0..steps_count {
        
    }
    
    todo!()
}
