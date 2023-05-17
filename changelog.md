## 1.0.0 `first release`
- added function __watch__, __unwatch__, __destroy__, __is_watched__

## 1.0.1
- change from package.lua to lit-meta (single file library)

## 1.0.2
- syntax error fix in lit-meta

## 1.0.3
- function __watch__ now clone event table
- events callback rework:
    * remove fget and fset (old filter methods)
    * funtions's self arg now give an access to internal keys and types