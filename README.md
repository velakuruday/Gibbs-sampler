# Gibbs sampler for Bayesian linear regression
The following repo present a Gibbs sampler for a full Bayesian linear regression with ![equation](https://latex.codecogs.com/gif.latex?l_1) and ![equation](https://latex.codecogs.com/gif.latex?l_2) penalty terms refered to as Ridge and LASSO regression respectively.  
 
## Bayesian linear regression with ![equation](https://latex.codecogs.com/gif.latex?l_2) (Ridge)
The full Bayesian regression with ![equation](https://latex.codecogs.com/gif.latex?l_2) regularization yields the following minimization function:

![equation](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Cboldsymbol%7B%5Cbeta%7D%7D_%7B%5Cmathrm%7BMAP%7D%7D%20%3D%20%5Cleft%5Clbrace%20%5Cunderset%7B%5Cboldsymbol%7B%5Cbeta%7D%7D%7B%5Cmathrm%7Barg%20%5C%20min%7D%7D%20%5Cfrac%7B%5Clambda%7D%7B2%7D%20%5Cparallel%20%5Ctextbf%7BA%7D%5Cboldsymbol%7B%5Cbeta%7D%20-%20%5Ctextbf%7By%7D%20%5Cparallel%5E%7B2%7D%20&plus;%20%5Cfrac%7B%5Cdelta%7D%7B2%7D%20%5Cparallel%20%5Cboldsymbol%7B%5Cbeta%7D%20%5Cparallel%5E%7B2%7D%20%5Cright%5Crbrace)

The matlab function is:

```matlab
[Beta, Lambda, Delta] = Gibbsridge(k, A, y)
```

## Bayesian linear regression with ![equation](https://latex.codecogs.com/gif.latex?l_1) (LASSO)
The full Bayesian regression with ![equation](https://latex.codecogs.com/gif.latex?l_1) regularization yields the following minimization function:

![equation](https://latex.codecogs.com/gif.latex?%5Chat%7B%5Cboldsymbol%7B%5Cbeta%7D%7D_%7B%5Cmathrm%7BMAP%7D%7D%20%3D%20%5Cleft%5Clbrace%20%5Cunderset%7B%5Cboldsymbol%7B%5Cbeta%7D%7D%7B%5Cmathrm%7Barg%20%5C%20min%7D%7D%20%5C%20%28%5Ctextbf%7By%7D%20-%20%5Ctextbf%7BA%7D%5Cboldsymbol%7B%20%5Cbeta%7D%29%5E%7B%5Cintercal%7D%20%28%5Ctextbf%7By%7D-%20%5Ctextbf%7BA%7D%5Cboldsymbol%7B%20%5Cbeta%7D%29%20&plus;%20%5Clambda%20%5Csum_%7Bi%3D1%7D%5E%7Bm%7D%20%7C%5Cbeta_i%20%7C%20%5Cright%5Crbrace)

The matlab function is:

```matlab
[Beta, Sigma, Tau, Lambda] = Gibbslasso(k, A, y)
```

## REFERENCES

- [Computational Uncertainty Quantification for Inverse Problems - Johnathan M. Bardsley](https://my.siam.org/Store/Product/viewproduct/?ProductId=29956644)
- [Bayesian lasso - Park & Casella ](https://people.eecs.berkeley.edu/~jordan/courses/260-spring09/other-readings/park-casella.pdf)


<img src="lasso.jpg" width="100%" >




