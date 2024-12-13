use crate::high_precision_arithmetics::{dekker::dekker, renormalize::renormalize, vec_sum::vec_sum};

pub fn mult_e(a: &Vec<f64>, b: &Vec<f64>, k: usize) -> Vec<f64> {
    let mut x = a.clone();
    let mut y = b.clone();

    if x.len() <= k {
        x.append(&mut vec![0.0; k - x.len()]);
    } else {
        x = Vec::from(&x[0..k]);
    }

    if y.len() <= k {
        y.append(&mut vec![0.0; k - y.len()]);
    } else {
        y = Vec::from(&y[0..k]);
    }

    let mut r = vec![0.0; k + 1];
    let mut e = vec![0.0; k * k];
    let mut p = vec![0.0; k];
    let mut e1 = p.clone();
    (r[0], e[0]) = dekker(x[0], y[0]);

    for n in 1..k {
        for i in 0..n {
            (p[i], e1[i]) = dekker(x[i], y[n - i]);    
        }

        let temp = [&p[0..n], &e[0..(n - 1) * (n - 1)]].concat();
        let z = vec_sum(&temp);
        r[n - 1] = z[0];
        &e[0..(n - 1) * (n - 1) + n - 1].iter_mut()
            .enumerate()
            .for_each(|(i, x)| {*x = z[i + 1]});
        
        let mut temp = [&e[0..(n - 1) * (n - 1) + n - 1], &e1[0..n]].concat();
        &e[0..n * n].iter_mut()
            .enumerate()
            .for_each(|(i, x)| {*x = temp[i]});
    }

    for i in 1..k {
        r[k] += x[i] * y[k - i];
    }
    for i in 0..k*k {
        r[k] += e[i];
    }

    r = renormalize(&r);

    (&r[0..k]).into()
}
