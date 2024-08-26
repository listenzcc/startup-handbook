import sys
import logging
import warnings

from . import default_settings


class Logger():
    def __init__(self, name, stream_level, filepath, encoding, pattern):
        '''Initialize based on settings.

        Args:
        - @name: logger name.
        - @stream_level: level of stream handler.
        - @filedir: dir of log file.
        - @encoding: encoding of log file.
        - @pattern: pattern of logging entries.
        '''
        # Make logger
        self.logger = logging.getLogger(name=name)
        # Set logger level as very low value
        self.logger.setLevel(logging.DEBUG)
        # Add stream handler
        self.add_stream_handler(level=stream_level, pattern=pattern)
        # Add file handler
        self.add_file_handler(level=logging.DEBUG, pattern=pattern,
                              filepath=filepath, encoding=encoding,
                              delay=False)

    def add_stream_handler(self, level, pattern):
        '''Print logging on stdout immediately.

        Args:
        - @level: The logging level of the stream handler.
        - @pattern: The pattern of the stream handler.
        '''
        # Settings
        self.stream_handler = logging.StreamHandler(sys.stdout)
        self.stream_handler.setFormatter(logging.Formatter(pattern))
        self.stream_handler.setLevel(level)
        # Add
        self.logger.addHandler(self.stream_handler)

    def add_file_handler(self, level, pattern, filepath, encoding, delay, mode='a'):
        '''Print logging on [filepath] in [encoding] with [delay] as [mode].

        Args:
        - @level: The logging level of the file handler.
        - @pattern: The pattern of the file handler.
        - @filepath: The filepath of the file.
        - @encoding: The encoding of the file.
        - @delay: The delay option of the file handler.
        - @mode: The mode option of the file handler, default value is 'a'.
        '''
        # Be careful with mode other than 'a'
        if not mode == 'a':
            warnings.warn(
                f'Mode is set as {mode}, it may erase existing file {filepath}.')
        # Settings
        self.file_handler = logging.FileHandler(
            filepath, mode=mode, encoding=encoding, delay=delay)
        self.file_handler.setFormatter(logging.Formatter(pattern))
        self.file_handler.setLevel(level)
        # Add
        self.logger.addHandler(self.file_handler)
        self.logger.filehandler = open(filepath, mode)


def new_logger(name=None, level=None, filepath=None, settings=default_settings, test=False):
    '''Generate your own logger quickly.

    The default_settings is used as the default values,
    its options can be changed by the input,
    if the input is not specified,
    we will just use the default value.

    In default settings,
    a log file named as 'default.log',
    with the logger named as 'root',
    can be found on your working dir,
    the console level will be set as logging.INFO.

    Args:
    - @name: The name of the logger.
    - @level: The level of the logger in console.
    - @filepath: The path of the logger file.
    - @settings: The default_settings dict.
    - @test: If test the logger setting at begining, default value is False.
    '''

    # Replace settings is provided.
    if name is not None:
        settings['name'] = name

    if level is not None:
        settings['stream_level'] = level

    if filepath is not None:
        settings['filepath'] = filepath

    # Generate logger on the settings.
    logger = Logger(**settings).logger

    # Test the setting if is required.
    if test:
        logger.info('Testing logger settings starts.')
        logger.debug('Debug message for check.')
        logger.info('Info message for check.')
        logger.warning('Warning message for check.')
        logger.error('Error message for check.')
        logger.critical('Critical message for check.')
        logger.info('Testing logger settings stops.')

    # Return the generated logger.
    return logger
