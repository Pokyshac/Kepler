use super::vec_sum::vec_sum_err_branch;

pub fn renormalize(x: &Vec<f64>) -> Vec<f64> {
    vec_sum_err_branch(x)
}
