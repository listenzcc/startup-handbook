import os
import configparser

import pandas as pd

from . import logger


class Config(object):
    '''High level config object
    '''

    def __init__(self, cfg_path='config.ini'):
        '''Initialize the setting file with [cfg_path].

        Args:
        - @cfg_path: The file path of the setting, default value is 'config.ini'

        Outs:
        - @config: The configparser instance.
        '''
        cfg = configparser.ConfigParser()
        cfg.read(cfg_path)
        self.cfg = cfg
        self.cfg_path = cfg_path
        logger.info(f'Config is initialized using {cfg_path}')

    def add(self, value, option='default', section='default', overwrite=True):
        '''Add [value] into [option] of [section],
        if it already exists,
        - it will be replaced if [overwrite] is True,
        - it will be unchanged if otherwise.

        It should be noticed that the [value] must to be string,
        thus we will actually add the value.__str__() instead of the value itself.

        Args:
        - @value: The value to be added.
        - @option: The option name to be added to.
        - @section: The session name to be added to.
        - @overwrite: If overwriting is allowed, default value is True.

        Outs:
        - The value being added, it will return None if fails.
        '''

        logger.debug(f'Adding {value} to {section}:{option}.')

        # Deal with the section,
        # if it does not exist,
        # create it.
        if not self.cfg.has_section(section):
            self.cfg.add_section(section)
            logger.debug(f'Section name not found, {section}, created it.')

        # Add the value
        # The option does not exist,
        # just add it.
        if not option in self.cfg[section]:
            self.cfg[section][option] = value.__str__()
            logger.info(f'Added {value} into {section}:{option}')

        # The option exists,
        # check overwrite option to replace it or not
        else:
            old = self.cfg[section][option]
            # Overwriting
            if overwrite:
                self.cfg[section][option] = value.__str__()
                logger.warning(
                    f'Option exists, {section}:{option} = {old}, replaced it with {value}.')

            # Add fails
            else:
                logger.error(
                    f'Option exists, {section}:{option} = {old}, not allowed to replace it, so I am doing nothing.')
                return None

        # Return what we may have added.
        return value.__str__()

    def get(self, option='default', section='default', default=None):
        '''Get the value from [section]:[option],
        if not found, will return the [default] as a placeholder,

        Args:
        - @option: The option name of interest, default value is 'default'.
        - @section: The section name of interest, default value is 'default'.
        - @default: The default placeholder if getting fails, default value is None.

        Outs:
        - The value we found.
        '''
        logger.debug(f'Getting value from {section}:{option}.')

        # Section is not found
        if not self.cfg.has_section(section):
            logger.warning(
                f'Section does not exist, {section}, using {default} instead.')
            return default

        # Option is not found
        if not option in self.cfg[section]:
            logger.warning(
                f'Option does not exist, {section}:{option}, using {default} instead.')
            return default

        value = self.cfg[section][option]
        logger.info(f'Found {value} from {section}:{option}')

        # Return what we found
        return value

    def save(self, overwrite=True):
        '''Save the cfg into [self.cfg_path],
        users can set the attribute on their own will.

        Args:
        - @overwrite: If allow to overwrite the existing cfg file, default value is True.

        Outs:
        - The path where the cfg file is saved, it will return None if fails.
        '''
        # File exists
        if os.path.isfile(self.cfg_path):
            # Overwriting
            if overwrite:
                self.cfg.write(open(self.cfg_path, 'w'))
                logger.warning(
                    f'File exists, {self.cfg_path}, overwrote it success.')

            # Not overwrite
            else:
                logger.warning(
                    f'File exists, {self.cfg_path}, not overwrote it, it means the saving fails.')

        # File does not exist
        else:
            # Folder exist,
            # just save it
            if os.path.isdir(os.path.dirname(self.cfg_path)) or os.path.dirname(self.cfg_path) == '':
                self.cfg.write(open(self.cfg_path, 'w'))
                logger.warning(
                    f'Wrote config success, {self.cfg_path}.')

            # Folder does not exist
            else:
                logger.error(
                    f'Saving fails, {self.cfg_path} can not be saved, the likely reason is the folder does not exist.')
                return None

        # Return where the cfg file may has been saved
        return self.cfg_path

    def dataframe(self):
        '''Convert the cfg into DataFrame'''
        columns = ['Section', 'Option', 'Value']
        df = pd.DataFrame(columns=columns)

        for sec in self.cfg:
            for opt in self.cfg[sec]:
                df = df.append(
                    dict(
                        Section=sec,
                        Option=opt,
                        Value=self.cfg[sec][opt]
                    ),
                    ignore_index=True)

        return df
