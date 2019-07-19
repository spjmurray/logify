# logify

Simple JSON log parser for the Couchbase Operator 2.0.0 that presents them in human readable form.

## Prerequisites

* python
* python-jinja2

## Installation

Clone the repo:

    git clone https://github.com/spjmurray/logify

Add a link into your PATH:

    ln -s ${PWD}/logify/bin/logify ~/bin

## Execution

Simply specify the log file to display:

    logify logify/samples/log
