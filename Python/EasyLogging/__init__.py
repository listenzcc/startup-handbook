'''
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
'''

import logging

default_settings = dict(
    name='root',
    stream_level=logging.INFO,
    filepath='default.log',
    encoding='utf-8',
    pattern='%(asctime)s %(name)-8s %(levelname)-8s %(message)-40s {{%(filename)s:%(lineno)s:%(module)s:%(funcName)s}}',
)
