# Counting Set Package

- Author: Chuncheng Zhang
- Date: 2021-03-01
- Version: 0.0

## Description

There is a common case when we want a set,
we hope its values are unique.

Additionally, in some case,
we want to count the value's counting by their being-added times,
with the counts, the values can be well sorted.

The origin "set" in python only supports non-repeat value set,
but not counting function.
The project is to provide it.

## Contains

- cset.py: The class file.

## Typical Using

```python
# Import
from CountingSet.cset import CountingSet

# Setup
cs = CountingSet()

# Add Values one-by-one
for j in range(10):
    cs.add('a')

for j in range(20):
    cs.add('b', 2)

for j in range(15):
    cs.add('c', 3)

# Get the sorted values
print(cs.to_list())
print(cs.to_list(reverse=False))
print(cs.total)
```
