# TODO A quick demonstration of how to move state in a React tree

Copyright (C) 2015 Your Golf Travel

## Try it / Run the tests

[TODO](http://ygt-mikekchar.github.io/todo)

## Description

This is just a description of how to move state in a React
tree up to the highest level. 

## License

The shell of this project was cloned from [Beans II](http://mikekchar.github.io/BeansII)
which is under AGPLv3.  So this project is also AGPLv3

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Development

Note:  If you just want to see the app run, or run the tests without
modifying anything and you are connected to the internet, you can
[just click here](http://ygt-mikekchar.github.io/todo)

### Runtime dependencies

The runtime/test dependencies are in git submodules, so you
have to fetch them.

```
git submodules update --init --recursive
```

### Development dependencies

TODO uses Node and Webpack to build the bundles used for
running the application or tests.  First install `node`
and `npm` according to the platform you are on.  Then

```
npm install
```

### How to build

```
npm run build
```

The built bundles are checked into github.  Please make sure
that you build before you push to github.  This is especially
important for pushing to gh-pages (see below)

### How to run the tests

After building the project, direct your browser to `spec/index.html`
in the  project directory.  It will run the Jasmine test suite.

### How to run the app

After building the project, direct your browser to `spec/index.html`
in the  project directory.  It will run the Jasmine test suite.

### How to Deploy
TODO is hosted on Github.  To deploy simply merge master into the
gh-pages branch.  Then push the gh-pages branch to Github.
It will be available on http://mikekchar.github.io/todo
within about 10 minutes.
