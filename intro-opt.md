---
title: Introduction to (Mathematical) Optimization
author: |
  | AJ Friend, Nick Henderson
  | (w/ material from Stephen Boyd and Steven Diamond)
date: June 28, 2015
---

## Optimization

. . .

Optimization

:   introducing a \textcolor{red}{change} to a \textcolor{blue}{system} to
    achieve a \textcolor{green}{better (or best) outcome}

. . .

Optimized

:   there does not exist a \textcolor{red}{(known) change} to a
    \textcolor{blue}{system} to achieve a \textcolor{green}{better outcome}

\note{
Here are some notes for this slide.  These are not placed in the slides pdf.  We
can use this for speaking notes corresponding to the slides!  BAM.
}

## Mathematical Optimization

Optimization

:   introducing a \textcolor{red}{change} to a \textcolor{blue}{system} to
    achieve a \textcolor{green}{better (or best) outcome}

Optimized

:   there does not exist a \textcolor{red}{(known) change} to a
    \textcolor{blue}{system} to achieve a \textcolor{green}{better outcome}

. . .

* \textcolor{blue}{system}: mathematical model

* \textcolor{red}{change}: change to input variables (parameters)

* \textcolor{green}{outcome}: a measure of performance of the model, objective
  function

\note{
  Basic idea is that this defines precise definitions for all of the words.
}

## The Raptor Problem

See other slides

## Optimization in one variable

$$
\begin{array}{ll}
\mbox{minimize} & f(x) \in C^2:\reals \to \reals
\end{array}
$$

. . .

* $x$ is a real variable

. . .

* $f(x)$ is the objective function, which returns a single real number

. . .

* Local optimization: look for a point $x^*$ such that $f(x^*) \le f(x)$ for all
  points $x$ near $x^*$

. . .

* Global optimization: look for a point $x^*$ such that $f(x^*) \le f(x)$ for all
points $x$ in domain of interest

. . .

* When $f(x)$ is twice continuously differentiable, then local optimization
  involves finding a point $x^*$ such that $f'(x^*)=0$ and $f''(x^*)>0$

## Optimization in one variable: axis
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-1.pdf}

## Optimization in one variable: definitions
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-2.pdf}

## Optimization in one variable: example objective function
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-3.pdf}

## Optimization in one variable: critical points, $f'(x) = 0$
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-4.pdf}

## Optimization in one variable: local optima
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-5.pdf}

## Optimization in one variable: local optima, $f''(x) = ?$
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-6.pdf}

## Optimization in one variable: unbounded below
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-7.pdf}

## Optimization in one variable: saddle point, $f'(x)=0$ and $f''(x) = 0$
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-8.pdf}

## Optimization in one variable: convex objective
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-9.pdf}

## Key definitions

* *domain*: space for input variable $x$
* *range*: space for output of objective function $f(x)$
* *critical point*: $f'(x) = 0$
* *local minimizer*: $f'(x) = 0$ and $f''(x) > 0$
* *local maximizer*: $f'(x) = 0$ and $f''(x) < 0$
* *saddle point*: $f'(x) = 0$ and $f''(x) = 0$
* *global minimizer*: $x^*$ such that $f(x^*) \le f(x)$ for all $x$ in domain

## Optimization in one variable: algorithm basics
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-10.pdf}

## Optimization in one variable: algorithm basics
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-11.pdf}

## Optimization in one variable: algorithm basics
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-12.pdf}

## Optimization in one variable: algorithm basics
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-13.pdf}

## Optimization in one variable: algorithm basics
\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-14.pdf}

## Optimization in one variable: algorithm basics

. . .

* Start with an initial guess $x_0$

. . .

* Goal: generate sequence that converges to solution
$$
x_0, x_1, x_2, x_3, \dots \to x^*
$$

. . .

* Notation for sequence and convergence: $\{x_k\} \to x^*$

. . .

* Key algorithm property: **_descent condition_**
$$
f(x_{k+1}) < f(x_k)
$$

. . .

* Technical algorithm property: **_convergence to solution_**
$$
|x_{k+1} - x_k| \to 0\ \text{if and only if}\ f'(x_k) \to 0
\ \text{and}\ \lim_{k\to\infty} f''(x_k) \ge 0
$$

## Optimization in two variables

$$
\begin{array}{ll}
\mbox{minimize} & f(x) \in C^2:\reals^2 \to \reals
\end{array}
$$

* $x$ is a 2-dimensional vector of real variables

* $f(x)$ is the objective function

    * First derivative or gradient of $f$ is written $\nabla f(x)$

    * Second derivate or Hessian of $f$ is written $\nabla^2 f(x)$

* We are looking for a point $x^*$ such that $\nabla f(x)=0$ and
  $\nabla^2 f(x) \succeq 0$.  Note that this is a *local* optimizer

## The gradient $\nabla f(x)$

Vector of variables:

$$
x = \begin{bmatrix} x_1 \\ x_2 \end{bmatrix}
$$

Gradient of $f$:

$$
\nabla f(x) = \begin{bmatrix}
  \frac{\partial f}{\partial x_1} \\[.5em]
  \frac{\partial f}{\partial x_2}
\end{bmatrix}
$$

## The Hessian $\nabla^2 f(x)$

$$
\nabla^2 f(x) = \begin{bmatrix}
  \frac{\partial^2 f}{\partial x_1^2}            && \frac{\partial^2 f}{\partial x_1 \partial x_2}\\[1em]
  \frac{\partial^2 f}{\partial x_2 \partial x_1} && \frac{\partial^2 f}{\partial x_2^2}
\end{bmatrix}
$$

## Surface plots and contours
- show local minimizer/maximizer critical point
- show saddle point

## Higher dimensions
- can't easily visualize
- need analysis

## Algorithms
- Basic loop
- Descent condition
- Gradient descent
- Newton's method

## Show example on rosenbrock function
- gradient descent vs. newton's method

## Two very important optimization problems
- linear least squares
- non-linear least squares

## Constraints
- basic idea of constraints
- work through example from multivariate calculus
- introduce idea of multipliers
- equality constraints
- inequality constraints
- linear constraints
- nonlinear constraints

## Penalty and barrier methods
- introduce a penalty into the objective to penalize constraint violation

## Linear programming

## Discrete variables
- Mixed integer programming
- Scheduling problems

## What's next
- Nonlinear programming
- Convex modelling
- Study of algorithms
- Modeling languages
- Automated differentiation

## Test image 1

\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-1.pdf}

## Test image 2

\includegraphics[width=\textwidth]{intro-opt-fig/graph-sequence-2.pdf}

