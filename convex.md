---
title: Convex Optimization
author: |
  | **AJ Friend**, Nick Henderson
  | (w/ material from Stephen Boyd and Steven Diamond)
  | Stanford University
date: June 28, 2015
---

# Mathematical optimization

## (mathy math)
optimization problem has form
$$
\begin{array}{ll} \mbox{minimize} & f_0(x)\\
\mbox{subject to} & f_i(x) \leq 0, \quad i=1,\ldots,m
\end{array}
$$

- $x\in \reals^n$ is \textbf{decision variable} (to be found)
- $f_0$ is objective function; $f_i$ are constraint functions
- problem data are hid inside $f_0,\ldots, f_m$
- variations: 
add equality constraints,
maximize a utility function, 
satisfaction (feasibility),
optimal trade off

## this talk
- high-level overview of convex optimization
- practical, lots of examples
- give a feel for what convex optimization is and what it can do
- few details. no theory
- some of the feel, philosophy, biases I've collected

## convexity definition
- sets
- functions
- in constraints: level sets are convex
- in objective: local minimizers are global
- picture?

## modeling with convexity
- sets of convex function and set *atoms*
- convexity preserving operations
    - addition, composition, partial minimization, \ldots
- transformation of seemingly non-convex problems into convex
- convex approximation
- using DCP (disciplined convex programming)
    - code is very code to the math
    - convenient for humans
    - does the problem transformations for you
    - calls the solver
    - transforms back into your variables


## Why convexity?
- trade off between supervision and modeling power
- nice theory
- theoretical guarantees, global optimum, interpretability: (of local minimizers)
- efficient algorithms give global solutions in polynomial time
- common language, conceptual unification
- useful subroutine for non-convex optimization (local convex approximation)
- (leaky) abstraction: once you've modeled as a convex problem, consider it solved
- with proper training, "your problem is convex" offers
deep, cosmic relief
- almost a technology, (like least squares)
- prototype quickly with generic solvers
- use other methods for speed and scale if necessary

## using convexity
- modeling
- modeling language
- construct instead of check for convexity
- composition rules

## CVXPY in one slide
lasso example
math matches code
lambda -> rho

## applications
- inversion
- engineering design
- optimal control
- model fitting

# Image in-painting

## Image in-painting
\includegraphics[width=\textwidth]{convex-fig/inpaint_text1}

## Example
guess pixel values in obscured/corrupted parts of image

- **decision variable** $x \in \reals^{m \times n \times 3}$
- $x_{i,j} \in [0,1]^3$ gives RGB values of pixel $(i, j)$
- many pixels missing
- known pixel IDs given by set $K$, values given by **data** $y \in \reals^{m \times n \times 3}$

**total variation in-painting**:
choose pixel values $x_{i,j} \in \reals^3$ to
minimize
$$
\mbox{TV}(x) = \sum_{i,j} \left\| \left[ \begin{array}{c}
x_{i+1,j}-x_{i,j}\\
x_{i,j+1}-x_{i,j}
\end{array}\right]\right\|_2
$$
that is, for each pixel, minimize distance to neighbors below and to the right, subject to known pixel values

## Convex model
$$
\begin{array}{ll} \mbox{minimize} & \mbox{TV}(x)\\
\mbox{subject to} & x_{i, j} = y_{i,j} \text{ if } (i,j) \in K
\end{array}
$$

- write what you want, not how to get it
- problem concisely and elegantly expressed
    - easily communicated
    - low overhead to tweaking model (rapid prototyping)
- we're done! (well, sort of)
    - express in code
    - invoke convex solver
    - made easier with model-and-solve tool, e.g., `CVXPY`
    - use other solvers/algorithms for speed or scale, if needed


## code example

```python
# K[i, j] == 1 if pixel value known, 0 if unknown
from cvxpy import *
variables = []
constr = []
for i in range(3):
    x = Variable(rows, cols)
    variables += [x]
    constr += [mul_elemwise(K, x - y[:,:,i]) == 0]

prob = Problem(Minimize(tv(*variables)), constr)
prob.solve(solver=SCS)
```

## Example
\includegraphics[width=\textwidth]{convex-fig/inpaint_text1}

## Example
\includegraphics[width=\textwidth]{convex-fig/inpaint_text2}

## Example ($80\%$ of pixels removed)
\includegraphics[width=\textwidth]{convex-fig/inpaint80_1}

## Example ($80\%$ of pixels removed)
\includegraphics[width=\textwidth]{convex-fig/inpaint80_2}


# Fault detection

## Statistical model fitting
- fitting parameters in statistical models is often convex
    - least-squares
    - general maximum-likelihood estimation
- when not convex, approximations can work surprisingly well

## Fault detection
- each of $n$ possible faults occurs independently with probability $p$
- encode as $x_i\in\{0,1\}$
- $m$ sensors measure system performance 
- sensor output is $y=Ax+v = \sum_{i=1}^n x_i a_i + v$
- $v$ is Gaussian noise with variance $\sigma^2$
- $a_i\in \reals^m$ is \emph{fault signature} for fault $i$
- signal-to-noise ratio
$$
\mathrm{SNR} = \frac{\Expect{\|Ax\|^2}}{\Expect{\|v\|^2}}
$$
- **goal**:
guess $x$ (which faults have occurred) given $y$ (sensor measurements)

## Maximum likelihood estimation
- choose $x\in \{0,1\}^n$
to minimize negative log likelihood function
$$
\ell(x) = \frac{1}{2 \sigma^2} \|Ax-y\|_2^2 +  \log(1/p-1)\ones^T x + c,
$$
- nonconvex, NP-hard
- instead solve convex (relaxed) problem
$$
\begin{array}{ll}
\mbox{minimize} &  \|Ax-y\|_2^2 + 2 \sigma^2 \log(1/p-1)\ones^T x\\
\mbox{subject to} &  0 \leq x_i \leq 1, \quad i=1, \ldots n
\end{array}
$$
and round
- called \textbf{relaxed ML} estimate

## Relaxed ML CVXPY code
$$
\begin{array}{ll}
\mbox{minimize} &  \|Ax-y\|_2^2 + 2 \sigma^2 \log(1/p-1)\ones^T x\\
\mbox{subject to} &  0 \leq x_i \leq 1, \quad i=1, \ldots n
\end{array}
$$

```python
from cvxpy import *
x = Variable(n)
tau = 2*log(1/p - 1)*sigma**2
obj = Minimize(sum_squares(A*x-y) + tau*sum_entries(x))
constr = [0<=x, x<=1]
Problem(obj,constr).solve()

x_rml = np.array(x.value).flatten()
x_rnd = (x_rml>=.5).astype(int)
```

## Example
$n=2000$ possible faults, $m=200$ measurements

$p = 0.01$, SNR $=5$

\includegraphics[width=\textwidth]{convex-fig/fault}

- perfect fault recovery!


# Robust Kalman filtering
## Robust Kalman filtering


# What we left out
- beautiful theory
    - optimality conditions
    - dual variables and Lagrange multipliers
    - certificates of optimality
- algorithms
    - (stochastic) gradient descent
    - interior point algorithms
    - optimal first order algorithms
    - problem splitting for large scale and distributed optimization


# References

##
- Convex optimization
- CVX
- CVXPY
