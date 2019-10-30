## Introduction
This is a emcas plugin to convert px unit to vw or vh in css or other files.

## How to use

* Download the `px-to-vw-vh.el` file to your emcas elisp configuration directory, generally it is `~/.emcas.d/lisp/` in MacOS. Or copy the content of `px-to-vw-vh.el` to a `.el` file in emcas el config path, and i suggest to also named `px-to-vw-vh.el`.

* Add blow code to your emcas config file, `~/.emcas.d/init.el` or `~/.emcas.d/custom.el` are ok.
```
(require 'px-to-vw-vh)
(global-set-key (kbd "C-c w") 'px->vw)
```
Now，you added a shortcut key to emacs, if it is inconvenient, you can set `F9` to do this.
```
(global-set-key [f9] 'px->vw)
```

* Move point to width number with "px" unit, and press shortcut key `C-c w`, px unit will convert to vw. For example:
```
.div {
    width: 200px;
}
```
use `C-c w` shortcur key in "200px" char, it will auto convert to
```
.div {
    width: 13.89vw;
}
```

## Explaintin

The vw value is convert by expression (/ (* px 100) viewport-width) and retain two float point.

## Remind

I gived default width of viewport is 1440, and not support to change by param, so if you want to change, please modify the first line constant of `px-to-vw-vh.el`.


