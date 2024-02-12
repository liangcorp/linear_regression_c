# Linear Regression Function

## Cost Function

We can measure the accuracy of our hypothesis function by using a cost function.
This takes an average difference (actually a fancier version of an average) of
all the results of the hypothesis with inputs from x's and the actual output y's.

This is an example of cost function for 2 features.
$$
J(θ_0, θ_1) = {{1 \over 2m} {\sum_{i=1}^{m}(h_θ(x_i) - y_i)^2}}
$$

## Gradient Descent

When specifically applied to the case of linear regression, a new form
of the gradient descent equation can be derived. We can substitute our
actual cost function and our actual hypothesis function and modify
the equation to :

$$
θ_0 := {θ_0 - α{{1 \over m}{\sum_{i=1}^{m}(h_θ(x_i) - y_i)}}}
$$

$$
θ_1 := {θ_1 - α{{1 \over m}{\sum_{i=1}^{m}(h_θ(x_i) - y_i)}}}
$$

Where $m$ is the size of the training set, $θ_0$ constant that will be
changing simultaneously with $θ_1$ and $x_i,y_i$ are values of the
given training set (data).

Note that we have separated out the two cases for $θ_j$ into separate equations
for $θ_0$ and $θ_1$; and that for $θ_1$ we are multiplying $x_i$ at the end due
to the derivative. The following is a derivation of ${∂ \over ∂θ_j}{J(θ)}$
for a single example:

$$
{∂ \over ∂θ_j}{J(θ)} = {∂ \over ∂θ_j}{1 \over 2}{(h_θ(x) - y)^2}
$$
$$
= 2 * {1 \over 2}(h_θ(x) - y) * {∂ \over ∂θ_j}{(h_θ(x) - y)}
$$
$$
= (h_θ(x) - y) * {∂ \over ∂θ_j}({\sum_{i=0}^{n}}θ_ix_i - y)
$$
$$
= (h_θ(x) - y)x_j
$$

The point of all this is that if we start with a guess for our hypothesis
and then repeatedly apply these gradient descent equations, our hypothesis
will become more and more accurate.

So, this is simply gradient descent on the original cost function $J$.
This method looks at every example in the entire training set on every step,
and is called batch gradient descent. Note that, while gradient descent can be
susceptible to local minima in general, the optimization problem we have posed
here for linear regression has only one global, and no other local, optima;
thus gradient descent always converges (assuming the learning rate $α$ is not
too large) to the global minimum. Indeed, $J$ is a convex quadratic function.
Here is an example of gradient descent as it is run to minimize a quadratic
function.

The ellipses shown above are the contours of a quadratic function. Also shown
is the trajectory taken by gradient descent, which was initialized at (48,30).
The $x$'s in the figure (joined by straight lines) mark the successive values
of $θ$ that gradient descent went through as it converged to its minimum.
