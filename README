# emacs-pkgdiff

`emacs-pkgdiff` is a reimplementation of
[pkgdiff](http://pkgsrc.se/pkgtools/pkgdiff) in Emacs Lisp.


## Installation

1. Clone the repository.
2. Run `gmake` to byte-compile `.el` files.
3. Add the following code snippet to your `.emacs.el` file:

```lisp
(add-to-list 'load-path "/PATH/TO/THE/REPOSITORY")
(autoload 'pkgvi "pkgdiff" "Edit a copy of specified file." t)
(autoload 'pkgdiff "pkgdiff" "Show differences from a backup file." t)
```


## Usage

### `pkgvi`

Type `M-x pkgvi RET` and choose a file. When you save changes to the
file, a backup file is automatically created if it doesn't exist yet.

### `pkgdiff`

Open a file and type `M-x pkgdiff RET`. It starts an Ediff session
showing differences between the backup and the current state.


## License
[CC0](https://creativecommons.org/share-your-work/public-domain/cc0/)
“No Rights Reserved”
