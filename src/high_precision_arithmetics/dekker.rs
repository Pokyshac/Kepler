use crate::high_precision_arithmetics::veltkamp::veltkamp;

pub fn dekker(x: f64, y: f64) -> (f64, f64) {
    let s = f64::ceil(53.0 / 2.0);
    let (xh, xl) = veltkamp(x, s);
    let (yh, yl) = veltkamp(y, s);
    let _p = x * y;
    let t1 = -_p + xh * yh;
    let t2 = t1 + xh * yl;
    let t3 = t2 + xl * yh;
    let p = t3 + xl * yl;

    (_p, p)
}
