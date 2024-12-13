pub fn sort_by_abs(a: &Vec<f64>) -> Vec<f64> {
    let n = a.len();
    let mut result = a.clone();
    for i in 0..n {
        for j in 0..n-i-1 {
            if f64::abs(result[j]) < f64::abs(result[j + 1]) {
                result.swap(j, j + 1);
            }
        }
    }

    result
}
