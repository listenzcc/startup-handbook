'''
@file: startup.py
@author: listenzcc
@readme:
    - Import useful package for daily python usage
    - It costs several seconds depending on the system
'''

# %%
import os
import json
import logging
import numpy as np
import pandas as pd
import plotly.express as px
import matplotlib.pyplot as plt

from collections import defaultdict
from pprint import pprint
from pathlib import Path
from tqdm.auto import tqdm

from IPython.core.display_functions import display


# %%


DEFAULT_LOGGING_KWARGS = dict(
    name='zcc',
    filepath='zcc.log',
    level_file=logging.DEBUG,
    level_console=logging.DEBUG,
    format_file='%(asctime)s %(name)s %(levelname)-8s %(message)-40s {{%(filename)s:%(lineno)s:%(module)s:%(funcName)s}}',
    format_console='%(asctime)s %(name)s %(levelname)-8s %(message)-40s {{%(filename)s:%(lineno)s}}'
)


def GENERATE_LOGGER(name, filepath, level_file, level_console, format_file, format_console):
    '''
    Generate logger from inputs,
    the logger prints message both on the console and into the logging file.
    The DEFAULT_LOGGING_KWARGS is provided to automatically startup

    Args:
        :param:name: The name of the logger
        :param:filepath: The logging filepath
        :param:level_file: The level of logging into the file
        :param:level_console: The level of logging on the console
        :param:format_file: The format when logging on the console
        :param:format_console: The format when logging into the file
    '''

    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)

    file_handler = logging.FileHandler(filepath)
    file_handler.setFormatter(logging.Formatter(format_file))
    file_handler.setLevel(level_file)

    console_handler = logging.StreamHandler()
    console_handler.setFormatter(logging.Formatter(format_console))
    console_handler.setLevel(level_console)

    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    return logger


# %%
'''
Global environment
'''
ENV = dict(
    oneCrive=os.environ.get('OneDriveCommercial', None),
    oneDrive=os.environ.get('OneDrive', None),
    datastation=Path(os.environ.get('OneDriveCommercial', ''), 'datastation')
)

# %%

'''
Display the packaged being automatically installed
'''
PACKAGES = dict()
for d in dir():
    if d.startswith('__'):
        continue
    PACKAGES[d] = eval(d)

# %%
logger = GENERATE_LOGGER(**DEFAULT_LOGGING_KWARGS)
logger.debug('Import packages {}'.format(PACKAGES))

# %%


if __name__ == '__main__':
    logger = GENERATE_LOGGER(**DEFAULT_LOGGING_KWARGS)
    logger.info('Testing logger settings starts.')
    logger.debug('Debug message for check.')
    logger.info('Info message for check.')
    logger.warning('Warning message for check.')
    logger.error('Error message for check.')
    logger.critical('Critical message for check.')
    logger.info('Testing logger settings stops.')

    pprint(PACKAGES)

# %%
