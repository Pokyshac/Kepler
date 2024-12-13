use crate::high_precision_arithmetics::{mult_e::mult_e, sub_e::sub_e};

pub fn inverse_num(a: &Vec<f64>, q: u32) -> Vec<f64> {
    let k = a.len();

    let mut b = a.clone();
    let p = usize::pow(2, q);
    if k <= p {
        b = [a.as_slice(), vec![0.0; p - k].as_slice()].concat();
    }

    let mut v = vec![0.0; p];
    let mut w = vec![0.0; p];
    let mut r = vec![0.0; p];
    r[0] = 1.0 / b[0];
    for i in 0..q {
        let num = usize::pow(2, i);    
        
        let temp = mult_e(&r[0..num].into(), &b[0..num].into(), 2 * num);
        &v[0..num * 2].iter_mut()
            .enumerate()
            .for_each(|(i, x)| {*x = temp[i]});
        
        let temp = sub_e(&[2.0].into(), &v[0..num * 2].into(), 2 * num);
        &w[0..num * 2].iter_mut()
            .enumerate()
            .for_each(|(i, x)| {*x = temp[i]});
        
        let temp = mult_e(&r[0..num].into(), &w[0..num * 2].into(), 2 * num);
        &r[0..num * 2].iter_mut()
            .enumerate()
            .for_each(|(i, x)| {*x = temp[i]});
    }

    r
}
