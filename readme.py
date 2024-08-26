# %%
import os

readme = os.path.join(os.path.dirname(__file__), 'README.md')

content = []


def read_all(folder):
    # For all children
    for e in os.listdir(folder):
        full = os.path.join(folder, e)
        # Dig into it
        if os.path.isdir(full):
            read_all(full)

        # Read it
        if e.endswith('.md'):
            content.append(open(full).read())


read_all(os.path.dirname(__file__))

with open(readme, 'w') as f:
    f.write('\n'.join([e for e in content]))

# %%
