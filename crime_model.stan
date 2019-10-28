// fit a linear regression model to the murder rate
data {
  int<lower=1> N; // number of datapoints
  real murder[N];    // random variable
  real penalty[N]; //law about death penalty
  real car[N]; 
}
parameters {
  real alpha;
  real beta;
  real gamma;
  real<lower=0> sigma;
}
model {
  for(i in 1:N){
      murder[i] ~ normal(alpha + beta*penalty[i] + gamma*car[i], sigma);
  }
  // priors
  alpha ~ normal(0,1);
  beta ~ normal(0,1);
  gamma ~ normal(0,1);
  sigma ~ normal(0,2); 
}
generated quantities {
  vector[N] murder_sim;    // simulated values from the posterior
  
  for (n in 1:N) {
    real murder_hat_n = alpha + beta * penalty[n] + gamma * car[n];
    murder_sim[n] = normal_rng(murder_hat_n, sigma);
  }
      
}
