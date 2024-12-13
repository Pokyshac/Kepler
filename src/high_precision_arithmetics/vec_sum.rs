use crate::two_sum::two_sum;

pub fn vec_sum(vector: &Vec<f64>) -> Vec<f64> {
    let n = vector.len();
    let mut result = vec![0.0; n];
    let mut s = *vector.last().unwrap();    
    for i in (0..n-1).rev() {
        (s, result[i + 1]) = two_sum(vector[i], s);
        // let temp = two_sum(vector[i], s);
        // s = temp.0;
        // result[i + 1] = temp.1; 
    }
    result[0] = s;

    result
}

pub fn vec_sum_err_branch(vector: &Vec<f64>) -> Vec<f64> {
    let n = vector.len();
    let mut start = vector[0]; 
    let mut result = vec![0.0; n];
    for i in 0..n-1 {
        (result[i], start) = two_sum(start, vector[i]);        
    }
    result[n - 1] = start;

    result
}
