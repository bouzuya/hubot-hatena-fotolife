# hubot-hatena-fotolife

A Hubot script that display random photos were uploaded to [Hatena::Fotolife][fotolife].

## Installation

    $ npm install git://github.com/bouzuya/hubot-hatena-fotolife.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-hatena-fotolife.git#TAG'

## Example

    bouzuya> hubot help hatena-fotolife
      hubot> hubot hatena-fotolife - display random photos were uploaded to Hatena::Fotolife

    bouzuya> hubot hatena-fotolife
      hubot> http://img.f.hatena.ne.jp/images/fotolife/b/bouzuya/20140818/20140818234149.gif

## Configuration

See [`src/scripts/hatena-fotolife.coffee`](src/scripts/hatena-fotolife.coffee).

## Development

### Run test

    $ npm test

### Run robot

    $ npm run robot

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[fotolife]: http://f.hatena.ne.jp/
[travis]: https://travis-ci.org/bouzuya/hubot-hatena-fotolife
[travis-badge]: https://travis-ci.org/bouzuya/hubot-hatena-fotolife.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-hatena-fotolife
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-hatena-fotolife.png
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
