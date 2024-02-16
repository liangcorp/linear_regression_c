# Logistic Regression

## Hypothesis Representation

We could approach the classification problem ignoring the fact that $y$ is
discrete-valued, and use our old linear regression algorithm to try to predict
$y$ given $x$. However, it is easy to construct examples where this method
performs very poorly. Intuitively, it also doesn't make sense for
$hθ(x)$ to take values larger than 1 or smaller than 0 when we know
that $y ∈ {0, 1}$. To fix this, let's change the form for our hypotheses
$h_θ(x)$ to satisfy $0≤h_θ(x)≤1$. This is accomplished by plugging
$θ^Tx$ into the Logistic Function.

Our new form uses the "Sigmoid Function," also called the "Logistic Function":

$h_θ(x)=g(θ^Tx)$

$z=θ^Tx$

$g(z)={1 \over {1+e^{−z}}}$

The following image shows us what the sigmoid function looks like:

![1WFqZHntEead-BJkoDOYOw_2413fbec8ff9fa1f19aaf78265b8a33b_Logistic_function](https://github.com/liangcorp/machine_learning_rust/assets/2737157/d9d35e7b-1cc1-42c1-9cea-9b58975bd892)

The function $g(z)$, shown here, maps any real number to the (0, 1) interval,
making it useful for transforming an arbitrary-valued function into a function
better suited for classification.

$h_θ(x)$ will give us the **probability** that our output is 1.
For example, $h_θ(x)=0.7$ gives us a probability of 70% that our output is 1.
Our probability that our prediction is 0 is just the complement of our
probability that it is 1 (e.g. if probability that it is 1 is 70%, then
the probability that it is 0 is 30%).

$h_θ(x)=P(y=1|x;θ)=1−P(y=0|x;θ)$

$P(y=0|x;θ)+P(y=1|x;θ)=1$

## Decision Boundary

In order to get our discrete 0 or 1 classification, we can translate the output
of the hypothesis function as follows:

$h_θ(x)≥0.5→y=1$

$h_θ(x)<0.5→y=0$

The way our logistic function g behaves is that when its input is greater than
or equal to zero, its output is greater than or equal to 0.5:

$g(z)≥0.5$

$\text{when }z≥0$

Remember.

$z=0,e^0=1⇒g(z)=1/2$

$z→∞,e^{−∞}→0⇒g(z)=1$

$z→−∞,e^∞→∞⇒g(z)=0$

So if our input to g is $θ^TX$, then that means:

$hθ(x)=g(θ^Tx)≥0.5$

$\text{when } θ^Tx≥0$

From these statements we can now say:

$θ^Tx≥0⇒y=1$

$θ^Tx<0⇒y=0$

The **decision boundary** is the line that separates the area where y = 0 and
where y = 1. It is created by our hypothesis function.

### Example

$5$

$θ=−1$

$0$

$y=1 \text{ if } 5+(−1)x_1 + 0x_2≥0$

$5−x_1≥0$

$−x_1≥−5$

$x_1≤5$

In this case, our decision boundary is a straight vertical line placed on the
graph where $x_1=5$, and everything to the left of that denotes y = 1, while
everything to the right denotes y = 0.

Again, the input to the sigmoid function g(z) (e.g. $θ^TX$) doesn't need to
be linear, and could be a function that describes a
circle (e.g. $z=θ_0+θ_1x_1^2+θ_2x^2_2$) or any shape to fit our data.

## Cost Function

We cannot use the same cost function that we use for linear regression because
the Logistic Function will cause the output to be wavy, causing many local
optima. In other words, it will not be a convex function.

Instead, our cost function for logistic regression looks like:

$$
J(θ)={1 \over{m}}\sum_{i=1}^{m}{Cost(h_θ(x^{(i)}), y^{(i)})}$
$$

$$
Cost(h_θ(x),y) = −\log(h_θ(x)) \text{    if } y = 1
$$

$$
Cost(h_θ(x),y)=−\log(1−h_θ(x)) \text{    if } y = 0
$$

When y = 1, we get the following plot for $J(θ)$ vs $h_θ(x)$:

Similarly, when y = 0, we get the following plot for $J(θ)$ vs $h_θ(x)$:

$$
Cost(h_θ(x), y) = 0 \text{ if } h_θ(x)=y
$$

$$
Cost(h_θ(x), y) → ∞ \text{ if } y=0 \text{ and } h_θ(x) → 1
$$

$$
Cost(h_θ(x), y) → ∞ \text{ if } y=1 \text{ and } h_θ(x) → 0
$$

If our correct answer 'y' is 0, then the cost function will be 0 if our
hypothesis function also outputs 0. If our hypothesis approaches 1, then the
cost function will approach infinity.

If our correct answer 'y' is 1, then the cost function will be 0 if our
hypothesis function outputs 1. If our hypothesis approaches 0, then the cost
function will approach infinity.

Note that writing the cost function in this way guarantees that $J(θ)$ is convex
for logistic regression.

## Simplified Cost Function and Gradient Descent

We can compress our cost function's two conditional cases into one case:

$Cost(h_θ(x),y) = −y \log(h_θ(x)) − (1 − y) \log(1 − h_θ(x))$

Notice that when y is equal to 1, then the second term $(1 − y) \log(1 − h_θ(x))$
will be zero and will not affect the result. If y is equal to 0, then the first
term $− y \log(h_θ(x))$ will be zero and will not affect the result.

We can fully write out our entire cost function as follows:

$$
J(θ)={−1 \over m} \sum_{i=1}^{m} [y^{(i)}\log(h_θ(x^{(i)}))+(1 − y^{(i)})
\log(1 − h_θ(x^{(i)}))]
$$

A vectorized implementation is:

$$
h=g(Xθ)
$$

$$
J(θ)={1 \over m} * −y^T\log(h)−(1−y)^T\log(1−h)
$$

### Gradient Descent

Remember that the general form of gradient descent is:

`Repeat {`

$θ_j := θ_j−α{∂ \over ∂θ_j}J(θ)$

`}`

We can work out the derivative part using calculus to get:

`Repeat {`

$$
θ_j:=θ_j−{α \over m}{\sum_{i=1}^{m}}(h_θ(x^{(i)})−y^{(i)})x_j^{(i)}
$$

`}`

Notice that this algorithm is identical to the one we used in linear
regression. We still have to simultaneously update all values in theta.

A vectorized implementation is:

$θ:=θ−{α \over m} X^T(g(Xθ)−\overrightarrow{y})$

## Multi-class Classification: One-vs-all

Now we will approach the classification of data when we have more than two
categories. Instead of y = {0,1} we will expand our definition so
that y = {0,1...n}.

Since y = {0,1...n}, we divide our problem into n+1 (+1 because the index
starts at 0) binary classification problems; in each one, we predict the
probability that 'y' is a member of one of our classes.

$$
y ∈ {0,1...n}
$$

$$
h_θ^{(0)}(x)=P(y=0|x;θ)
$$

$$
...
$$

$$
h_θ^{(n)}(x)=P(y=n|x;θ)
$$

$$
prediction = max_i(h_θ^{(i)}(x))
$$

We are basically choosing one class and then lumping all the others into a
single second class. We do this repeatedly, applying binary logistic
regression to each case, and then use the hypothesis that returned the
highest value as our prediction.

The following image shows how one could classify 3 classes:

![cqmPjanSEeawbAp5ByfpEg_299fcfbd527b6b5a7440825628339c54_Screenshot-2016-11-13-10 52 29](https://github.com/liangcorp/machine_learning_rust/assets/2737157/4261b127-e234-411d-aad8-aa6feeff42fb)

### To summarize

Train a logistic regression classifier $h_θ(x)$ for each class $(i)$ to
predict the probability that $P(y = i|x;θ)$.

To make a prediction on a new x, pick the class that maximizes $h_θ(x)$
