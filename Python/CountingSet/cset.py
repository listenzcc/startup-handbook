

# %%
class CountingSet(object):
    '''Customized set with its values are counted,
    the **counting** refers the adding counting of the values are recorded,
    and the property is in ready-to-use state.
    '''

    def __init__(self):
        '''Trivial initialization method.
        An empty dict is created.
        '''
        # cdict, the name refers it is a dict for counting,
        # the value of the set is the key of the dict.

        # Create empty cdict
        self.cdict = dict()
        # Total number of the empty cdict is 0
        self.total = 0
        pass

    def add(self, value, weight=1):
        '''Adding method,

        Args:
        - @value: The value to add;
        - @weight: The counting weight, default value is 1,
                   the weight value will be forced converted to int type.

        Outs:
        - @count: The count of the value, **AFTER** being added.
        '''

        # Make sure weight is int
        weight = int(weight)
        assert(isinstance(weight, int))

        # Add
        # If has value
        if value in self.cdict:
            self.cdict[value] += weight
        # If doesn't have value
        else:
            self.cdict[value] = weight

        self.total += weight

        # Return the counting
        return self.cdict[value]

    def to_list(self, reverse=True):
        '''Get all values as a list,
        the order is based on the function of [sort]

        Args:
        - @sort: The sort function.
        - @reverse: The reverse option of sorting, default value is True,
                    by default, the value with most counting is at the first.

        Outs:
        - The well sorted list of all values.
        '''
        return sorted(self.cdict.keys(), key=lambda e: self.cdict[e], reverse=reverse)


# %%

if False:
    # How-to-use
    cs = CountingSet()

    for j in range(10):
        cs.add('a')

    for j in range(20):
        cs.add('b', 2)

    for j in range(15):
        cs.add('c', 3)

    print(cs.to_list())
    print(cs.to_list(reverse=False))
    print(cs.total)


# %%
