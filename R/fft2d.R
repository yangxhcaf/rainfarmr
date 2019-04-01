#' Compute spatial Fourier spectrum of field averaged over shells in modulus of wavenumber
#' @param z The input field with dimensions `c(N, N)`
#' @return Spectral power (square of absolute value of amplitudes) for `k=1:N/2`.
#' @export
fft2d <- function(z) {
  ns <- dim(z)[1]
  ns2 <- floor(ns / 2)
  zf <- abs(fft(z) / (ns * ns)) ^ 2
  zf0 <- zf
  zf[ns2 + 1, ] <- zf0[ns2 + 1, ] / 2
  zf[ , ns2 + 1] <- zf0[ , ns2 + 1] / 2
  kx <- rep(c(0:(ns / 2), (-ns / 2 + 1):-1), ns)
  dim(kx) <- c(ns, ns)
  km <- sqrt(kx ^ 2 + t(kx) ^ 2)
  nn <- integer(ns)
  fx <- numeric(ns)
  for (i in 1:(ns * ns)) {
    ik <- floor(km[i] + 1.5)
    fx[ik] <- fx[ik] + zf[i]
    nn[ik] <- nn[ik] + 1
  }
  fx <- fx[2:(ns2 + 1)] / nn[2:(ns2 + 1)];
  return(fx)
}