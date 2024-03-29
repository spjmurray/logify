# logify

Simple JSON log parser for the Couchbase Operator 2.0.0 that presents them in human readable form.

## Prerequisites

* python
* jinja2
* pyyaml

Or in general, and far less likely to be out of date:

    pip3 install requirements.txt

## Installation

Clone the repo:

    git clone https://github.com/spjmurray/logify

Add a link into your PATH:

    ln -s ${PWD}/logify/bin/logify /usr/local/bin

## Execution

Operator 2.2 and above:

    logify path/to/cbopinfo-directory

Operator 2.1 and below, specify the log file to display:

    logify path/to/log-file

### Timezones

By default, the script will render dates in the local time zone.
If you want to embrace your inner Cher and turn back time, you can do by specifying the timezone:

    TZ=Asia/Tokyo logify path/to/logs
