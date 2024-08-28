# experimental-sbt-cache

Is `sbt compile` cached inside the container?

## Usage

Prepare an image for sbt.

``` shell
make sbt
```

First compilation.

``` shell
make compile
```

Second compilation, maybe faster than the first time

``` shell
make compile
```

Clear caches.

``` shell
make clean
```

## Project template

Generated from [sbt new sbt/scala-seed.g8](https://www.scala-sbt.org/1.x/docs/Hello.html).
