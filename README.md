## Hand Book of Useful Commands

### Using D3

```html
<script src="https://d3js.org/d3.v6.min.js"></script>
```

### Python Import

```python
import os
import numpy as np
import pandas as pd

import plotly.graph_objects as go
import plotly.express as px

from EasyLogging.logger import new_logger

# Set the logger and use it
logger = new_logger(name='projectName', filepath='logFile.log')
```

### Template Readme

```md
## Title

- Author:
- Date:
- Version:

### Description

Background, What, Achieve.

### Contains

The contains of the project|package|folder.

### Example Usage

The code block.
```

# Powershell Can-be-Used Scripts

- Author: Chuncheng Zhang
- Date: 2021-03-01
- Version: 0.0

## Description

The collection is used to provide some functionality scripts,
to make powershell **basically human useable**.

## Contains

- customApps.ps1: The main script.
- type/fileTypeEnhance.ps1xml: The config xml file to enhance file type.

## Typical Using

The script and the config file are used to initialize to powershell terminal,
they are used in the startup script,
the [profile.ps1] start-up file in my case.

```powershell
# Basic setup
$serverIP = '----'
$serverUser = '----'
$scriptFolder = "$env:OneDrive\Scripts\Powershell"

# Using config file
Update-TypeData -AppendPath $scriptFolder\type\\fileTypeEnhance.ps1xml -verbose

# Run the script
. "$scriptFolder\customApps.ps1"
```

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

# Easy-to-Log Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable logging management in python.
The core is the logging package.

It frees your hands from noisy logging settings.
By default,

- It logs on both terminal and file, in a well-organized format.
- The terminal uses the level of INFO.
- The file uses the level of DEBUG.
- The format has several columns and well spaced.

## Contains

- logger.py: The main logging class.

## Typical Using

```python
from EasyLogging.logger import new_logger

# Set the logger and you can just use it
logger = new_logger(name='projectName', filepath='logFile.log')
```

# Easy-to-Set Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable setting management in python.
The core is the configparser package.

It can be used to manage your program settings,
in the structure of **Section:Option -> Value**.
The settings can be **quickly accessed** by the manager.
And the settings can be easily **saved** to .ini files and **displayed** by pandas DataFrame.
Additionally, it requires only one line to **restore** your settings.

## Contains

- config.py: The main configure class.

## Typical Using

```python
from EasySetting.config import Config

# Init config or Restore from file
cfg = Config(cfg_file='configFile.ini')

# Save config
cfg.save()

# Display using DataFrame
cfg.display()
```

## Hand Book of Useful Commands

### Using D3

```html
<script src="https://d3js.org/d3.v6.min.js"></script>
```

### Reasonable Import

```python
import os
import numpy as np
import pandas as pd

import plotly.graph_objects as go
import plotly.express as px

from EasyLogging.logger import new_logger

# Set the logger and use it
logger = new_logger(name='projectName', filepath='logFile.log')
```

### Template Readme

```md
## Title

- Author:
- Date:
- Version:

### Description

Background, What, Achieve.

### Contains

The contains of the project|package|folder.

### Example Usage

The code block.
```

# Powershell Can-be-Used Scripts

- Author: Chuncheng Zhang
- Date: 2021-03-01
- Version: 0.0

## Description

The collection is used to provide some functionality scripts,
to make powershell **basically human useable**.

## Contains

- customApps.ps1: The main script.
- type/fileTypeEnhance.ps1xml: The config xml file to enhance file type.

## Typical Using

The script and the config file are used to initialize to powershell terminal,
they are used in the startup script,
the [profile.ps1] start-up file in my case.

```powershell
# Basic setup
$serverIP = '----'
$serverUser = '----'
$scriptFolder = "$env:OneDrive\Scripts\Powershell"

# Using config file
Update-TypeData -AppendPath $scriptFolder\type\\fileTypeEnhance.ps1xml -verbose

# Run the script
. "$scriptFolder\customApps.ps1"
```

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

# Easy-to-Log Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable logging management in python.
The core is the logging package.

It frees your hands from noisy logging settings.
By default,

- It logs on both terminal and file, in a well-organized format.
- The terminal uses the level of INFO.
- The file uses the level of DEBUG.
- The format has several columns and well spaced.

## Contains

- logger.py: The main logging class.

## Typical Using

```python
from EasyLogging.logger import new_logger

# Set the logger and you can just use it
logger = new_logger(name='projectName', filepath='logFile.log')
```

# Easy-to-Set Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable setting management in python.
The core is the configparser package.

It can be used to manage your program settings,
in the structure of **Section:Option -> Value**.
The settings can be **quickly accessed** by the manager.
And the settings can be easily **saved** to .ini files and **displayed** by pandas DataFrame.
Additionally, it requires only one line to **restore** your settings.

## Contains

- config.py: The main configure class.

## Typical Using

```python
from EasySetting.config import Config

# Init config or Restore from file
cfg = Config(cfg_file='configFile.ini')

# Save config
cfg.save()

# Display using DataFrame
cfg.display()
```

# Powershell Can-be-Used Scripts

- Author: Chuncheng Zhang
- Date: 2021-03-01
- Version: 0.0

## Description

The collection is used to provide some functionality scripts,
to make powershell **basically human useable**.

## Contains

- customApps.ps1: The main script.
- type/fileTypeEnhance.ps1xml: The config xml file to enhance file type.

## Typical Using

The script and the config file are used to initialize to powershell terminal,
they are used in the startup script,
the [profile.ps1] start-up file in my case.

```powershell
# Basic setup
$serverIP = '----'
$serverUser = '----'
$scriptFolder = "$env:OneDrive\Scripts\Powershell"

# Using config file
Update-TypeData -AppendPath $scriptFolder\type\\fileTypeEnhance.ps1xml -verbose

# Run the script
. "$scriptFolder\customApps.ps1"
```

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

# Easy-to-Log Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable logging management in python.
The core is the logging package.

It frees your hands from noisy logging settings.
By default,

- It logs on both terminal and file, in a well-organized format.
- The terminal uses the level of INFO.
- The file uses the level of DEBUG.
- The format has several columns and well spaced.

## Contains

- logger.py: The main logging class.

## Typical Using

```python
from EasyLogging.logger import new_logger

# Set the logger and you can just use it
logger = new_logger(name='projectName', filepath='logFile.log')
```

# Easy-to-Set Package

- Author: Chuncheng Zhang
- Date: 2021-02-25
- Version: 0.0

## Description

The aim is to provide a reuseable setting management in python.
The core is the configparser package.

It can be used to manage your program settings,
in the structure of **Section:Option -> Value**.
The settings can be **quickly accessed** by the manager.
And the settings can be easily **saved** to .ini files and **displayed** by pandas DataFrame.
Additionally, it requires only one line to **restore** your settings.

## Contains

- config.py: The main configure class.

## Typical Using

```python
from EasySetting.config import Config

# Init config or Restore from file
cfg = Config(cfg_file='configFile.ini')

# Save config
cfg.save()

# Display using DataFrame
cfg.display()
```
