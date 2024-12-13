pub fn veltkamp(x: f64, s: f64) -> (f64, f64) {
    let c = f64::powf(2.0, s) + 1.0;

    let g = c * x;
    let d = x - g;
    let xh = d + g;
    let xl = x - xh;

    (xh, xl)
}
