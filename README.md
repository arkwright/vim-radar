# Radar

Enhance [fugitive.vim](https://github.com/tpope/vim-fugitive) with easy diffing
of changes between two commits.

## Why?

Because sometimes you just need to see the following:

1. Exactly which files were changed between two specific commits.
1. The precise changes to those files.

And because it's nice to have it all wrapped up in an intuitive user interface.

## Installation

Get [Pathogen](https://github.com/tpope/vim-pathogen).

Get [fugitive.vim](https://github.com/tpope/vim-fugitive).

And then:

    cd ~/.vim/bundle
    git clone https://github.com/arkwright/vim-radar.git

Only tested in Vim 7.4 on OS X using MacVim.

**This plugin is very much a prototype. Your mileage may vary!**

## Usage

Ensure that Vim's current working directory is pointed at a local checkout of
one of your Git repos, and execute:

    :Radar [revision1] [revision2]

The revisions are optional, and are passed to fugitive's `:Gdiff`. If you pass
no revisions, you see the working copy diffed against the index. One revision
diffs the working copy against that revision. Passing two revisions diffs those
two revisions against each other.

When calling `:Radar`, a file list will appear in a new split window. Pressing
`<CR>` on any line in the file list will open a diff view for that file, using
the revisions that you passed to `:Radar`.

## Configuration

You can change the name of the invocation command like so:

    :let g:radar_command_name = 'Sonar'

The above line would enable you to invoke Radar by running the `:Sonar` command.

## Bugs

Probably lots.

Please open a Github issue if you notice something is amiss.

## Contributing

Pull requests, feature requests, ideas, bug reports, etc., are all welcome.

## Changelog

Uses [Semantic Versioning](http://semver.org/).

**0.1.1** (2014-10-9)

* Fix diff failing when current working directory is changed.
* Fix buffers not sharing window width.
* Fix auto-advance to first diff not working if first diff is on first line.
* Fix diff selection mapping not local to buffer.
* Fix `:Radar` command not being created if it is a substring of a longer
  command name, e.g., `:Radars`.

**0.1.0** (2014-08-27)

* Add `:Radar` command, with file list, `:Gdiff` integration, and convenient
  diff mapping.
* Add `g:radar_command_name` option.

## Credits

Radar is lovingly crafted by [Robert
Arkwright](https://github.com/arkwright).

Radar is but a tiny feature added to Tim Pope's amazing
[fugitive.vim](https://github.com/tpope/vim-fugitive).

This plugin would not have been possible without Steve Losh's incredible book:
[Learn Vimscript the Hard
Way](http://learnvimscriptthehardway.stevelosh.com/).

## License

[Unlicense](http://unlicense.org/)
