use crate::high_precision_arithmetics::sort_by_abs::sort_by_abs;
use crate::high_precision_arithmetics::vec_sum::vec_sum_err_branch;

use super::{sort_by_abs, vec_sum};

pub fn sub_e(a: &Vec<f64>, b: &Vec<f64>, k: usize) -> Vec<f64> {
    let mut sorted_a = sort_by_abs(a);
    let mut sorted_b = sort_by_abs(b);

    let mut temp: Vec<f64> = sorted_b.iter()
        .map(|x| {-1.0 * x})
        .collect();
    sorted_a.append(&mut temp);
    
    let mut result = vec_sum_err_branch(&vec_sum::vec_sum(&sorted_a));
    if result.len() < k {
        result.append(&mut vec![0.0; k - result.len()]);
    } else {
        result = Vec::from(&result[0..k]);
    }

    result
}
