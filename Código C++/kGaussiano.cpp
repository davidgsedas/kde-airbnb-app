#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector kdeGaussiano(NumericVector x, NumericVector data, double bandwidth) {
  int n = x.size();
  int m = data.size();
  NumericVector output(n);
  
  for(int i = 0; i < n; i++) {
    double sum = 0;
    for(int j = 0; j < m; j++) {
      double u = (x[i] - data[j]) / bandwidth;
      sum += exp(-0.5 * u * u) / sqrt(2 * M_PI);
    }
    output[i] = sum / (m * bandwidth);
  }
  
  return output;
}
