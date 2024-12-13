#![allow(unused_variables, unused_imports, dead_code, unused_must_use)]

use high_precision_arithmetics::mult_e::mult_e;
use high_precision_arithmetics::sort_by_abs::sort_by_abs;
use high_precision_arithmetics::two_sum;
use high_precision_arithmetics::vec_sum::vec_sum_err_branch;
use high_precision_arithmetics::vec_sum;
use high_precision_arithmetics::dekker;
use high_precision_arithmetics::veltkamp;
use high_precision_arithmetics::seq_sqrt::seq_sqrt;


mod high_precision_arithmetics;

fn main() {
    let v1 = vec![1.0, 3.0, 2.0];
    let v2 = vec![4.0, 5.2, 3.1];
    let k = 5;
    let v = mult_e(&v1, &v2, k);
    for x in v {
        println!("{}", x);
    }

    // let mut e = vec![82.445; 20];
    // let q = 5;
    // let v = seq_sqrt(&e, q);
    // for x in v {
    //     println!("{}", x);
    // }
}
