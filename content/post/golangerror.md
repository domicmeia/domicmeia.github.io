+++
title = "How to fix the warning: composite literal uses unkeyed fields"
date = 2024-01-30T20:29:24+09:00
tags = ["Warning"]
summary = "warning: composite literal uses unkeyed fields"
+++
# ..struct literal uses unkeyed fields

## How to fix

Add fields name struct to literal.

## Do we need to fix this warning and Why?

The warning is there to safeguard you from changes in the third-party API breaking your code silently.

Ignoring this vet warning has the potential to lead to really nasty and hard to track down runtime bugs, so you'd be better off if you were to always specify the keys of 3rd party structs explicitly.

Such would be the case if the maintainers of the library you are using decided to change the order of elements in their struct for whatever reason. 

For example, switching Key with Value, in the OP case. Your code would still appear to compile just fine, but what you intended to be the key would now be passed as the value and vice versa, and things would just start breaking in unexpected ways.