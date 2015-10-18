[![Build Status](https://travis-ci.org/masone/codeclimate-jscpd.svg?branch=master)](https://travis-ci.org/masone/codeclimate-jscpd)

# Code Climate jscpd engine

`codeclimate-jscpd` is a Code Climate engine that wraps [jscpd](https://www.npmjs.com/package/jscpd). 

Jscpd is a duplicate code (copy/paste) detector for programming code. It supports JavaScript, CoffeeScript, PHP, Ruby, Python, Less, Go, Java, C#, C++ and C. You can run it on your command line using the Code Climate CLI, or on the [codeclimate analysis platform](https://codeclimate.com).


### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
2. Run `codeclimate engines:enable jscpd`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
3. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.
