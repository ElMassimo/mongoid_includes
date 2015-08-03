Mongoid::Includes
=====================
[![Gem Version](https://badge.fury.io/rb/mongoid_includes.svg)](http://badge.fury.io/rb/mongoid_includes)
[![Build Status](https://travis-ci.org/ElMassimo/mongoid_includes.svg)](https://travis-ci.org/ElMassimo/mongoid_includes)
[![Test Coverage](https://codeclimate.com/github/ElMassimo/mongoid_includes/badges/coverage.svg)](https://codeclimate.com/github/ElMassimo/mongoid_includes)
[![Code Climate](https://codeclimate.com/github/ElMassimo/mongoid_includes.png)](https://codeclimate.com/github/ElMassimo/mongoid_includes)
[![Inline docs](http://inch-ci.org/github/ElMassimo/mongoid_includes.svg)](http://inch-ci.org/github/ElMassimo/mongoid_includes)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ElMassimo/mongoid_includes/blob/master/LICENSE.txt)

`Mongoid::Includes` improves eager loading in Mongoid, supporting polymorphic associations, and up to two-levels of eager loading.

### Usage

```ruby
Album.includes(:songs).includes(:musicians, from: :band)
```

## Advantages

* Avoid N+1 queries and get better performance.
* No boilerplate code is required.
* Can avoid loading all the related documents if necessary.


License
--------

    Copyright (c) 2015 Máximo Mussini

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
