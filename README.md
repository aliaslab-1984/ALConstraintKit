#  ALConstraintKit

This framework lets you easily layout your views without using storyboards.
You just need to type the description for each view.
To get started just import ALConstraintKit into your project.
Next import the module ALConstraintKit inside one of your views/View Controllers.


## The benefits:

Normally the flow for creating a UI programmatically looks like this:

```swift
let view = UIView()

view.backgroundColor = .red

view.translatesAutoresizingMaskIntoConstraints = false

let constraints : [NSLayoutConstraint] = [
  view.topAnchor.constraint(equalTo: self.superView.topAnchor, constant: 10),
  view.bottomAnchor.constraint(equalTo: self.superView.bottomAnchor, constant: -10),
  view.leadingAnchor.constraint(equalTo: self.superView.leadingAnchor, constant: 10),
  view.trailingAnchor.constraint((equalTo: self.superView.trailingAnchor, constant: -10)
]

NSLayoutConstraint(activate: constraints)
```

As you can see this only sets up one view; specifically we are aiming to fill the superview with the new view and to apply a fixed amount of spacing from all the edges.
The same result could be done with ALConstraintKit in a more __concise__ way!
``` swift
let view = UIView(tamic: false, backgroundColor: .red)

view.fillSuperView(padding: .init(all: 10))
```

Only ***two*** lines of code instead of ***8***!

***
## Not only constraints:

This framework provides some useful tools and initializers to make the process of creating UI even smoother!

One of this tools are the custom UIEdgeInsets initializers, that lets you type only the edges that you want to specify instead of typing all of them.

``` swift
let insets = UIEdgeInsets(axis: .vertical(top: 10, bottom 10))

let squaredInsets = UIEdgeInsets(all: 10)
```

+ The first initializer let's you choose the axis you'll need to set the spacing (vertical and horizontal).
+ The latter lets you apply the same amount of spacing to all the edges.

Pretty handy right ?!

Normally you initialize it like this:

``` swift
let insets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
```
***
## More complex scenarios:

ALConstraintKit offers a way to simply apply single constraints rules with this syntax:

``` swift
childView.leadingAnchor.anchor(to: self.view.leadingAnchor)

childView.trailingAnchor.anchor(to: self.view.trailingAnchor)
```

In this example we are declaring that the childView needs to match the leading and trailing anchor of *view*.
If you are a lazy typer, like me, there's an easier and faster way to declare it:

``` swift
childView.copyAndApplyHorizontalConstraint(from: self.view)
```

This is also available for *vertical* constraints, but you can also copy just one of the two involved (*top* and *bottom*).
___
#### In addition:

You can also get a reference to the constraint applied with the *anchor* method by assigning the result value to a variable:

``` swift
var constraintRefer = someView.centerYAnchor.anchor(to: self.view.centerYAnchor, constant: 0)
```

And edit the constant associated to the constraint later:
``` swift
constraintRefer.constant = 200
```
This is useful for animations or for invalidating existing constraints.
Remember to call *view.layoutIfNeeded()* so the editing will effectively take place.
*A easier way to invalidate constraints is under developement.*
