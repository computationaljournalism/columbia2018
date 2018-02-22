# -*- coding: utf-8 -*-
from setuptools import setup

setup(
    name='alexa_bot',
    version='0.1',
    description='The Simple Alexa Bot Library',
    url='https://github.com/computationaljournalism/columbia2018/library/alexa_bot',
    author='Michael Young',
    author_email='my2456@columbia.edu',
    license='MIT',
    packages=['alexa_bot'],
    install_requires=[
        'flask_ask'
    ],
    zip_safe=False
)
