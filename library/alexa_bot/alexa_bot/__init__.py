# -*- coding: utf-8 -*-
''' Simple wrapper library for Flask Ask to simplify the setup (mostly decorators)
'''
from flask import Flask
from flask_ask import Ask

class AlexaBot(object):
    ''' ...
    '''

    def __init__(self):
        pass

    def start(self, config, debug=True):
        ''' set up the
        '''

        # set up the app
        self.app = Flask(__name__)
        self.ask = Ask(self.app, '/')

        # load config
        for intent_name, func in config:
            # the config is a list of tuples with:
            # intent name
            # intent method to call 
            func = self.ask.intent(intent_name)(func)

        # start it up
        self.app.run(debug=debug)
