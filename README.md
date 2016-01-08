# Function Index

A single-page application
with a dynamic index of functions in my book
<a href="https://github.com/joelgrus/data-science-from-scratch">Data Science from Scratch</a>.
Built using
<a href="https://github.com/slamdata/purescript-halogen">purescript-halogen</a>.

![Image of App](https://raw.githubusercontent.com/joelgrus/dsfs-function-index/master/index-of-functions.png)

You can see it up and running at

<a href="http://joelgrus.com/experiments/function-index/">http://joelgrus.com/experiments/function-index/</a>

I built this for two reasons. First, because my loyal readers
<a href="https://github.com/joelgrus/data-science-from-scratch/issues/21">requested it</a>.
And second, because I'm trying to learn how to build things in Purescript.

It turned out to be sort of a pain, mostly because I had a hell of a time implementing
the onKeyUp logic. (see, e.g. <a href = "https://github.com/joelgrus/dsfs-function-index/blob/master/src/Main.purs#L59">here</a>)

If you want to run it yourself, do

```
pulp browserify --optimise --to dist/index.js
```

and then start a web server in that directory.

Incidentally, for some reason if you leave off the optimise [sic] flag,
the resulting code doesn't work.
I don't really have the motivation to figure out why.
