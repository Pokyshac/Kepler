
//Rump-Ogita-Oishi

pub fn sum_rump(vector: Vec<f64>) -> f64 {
    let mut sum = 0.0;
    let mut c = 0.0;
    let mut temp: (f64, f64);
    for value in vector.iter() {
        temp = two_sum(sum, *value);
        sum = temp.0;
        c += temp.1;
    }

    sum + c
}

pub fn two_sum(a: f64, b: f64) -> (f64, f64) {
    let s = a + b;
    let bs = s - a;
    let _as = s - bs;
    let t = (b - bs) + (a - _as);

    (s, t)
}
