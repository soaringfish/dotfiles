#!/usr/bin/env python

import pandocfilters as pf
import re

def latex(s):
    return pf.RawBlock('latex', s)

re_block = re.compile('^/?(\w*block):?(.*)$')
re_env   = re.compile('^/?(\w*):?(.*)$')

def mk_columns(k, v, f, m):
    if k == "Para":
        value = pf.stringify(v)
        if value.startswith('[') and value.endswith(']'):
            content = value[1:-1]
            # columns
            if content == "columns":
                return latex(r'\begin{columns}')
            elif content == "/columns":
                return latex(r'\end{columns}')
            elif content.startswith("column="):
                return latex(r'\column{%s\textwidth}' % content[7:])
            elif content.startswith("columns="):
                return latex(r'\begin{columns}\column{%s\textwidth}' % content[8:])
            # minipage
            if content.startswith( "minipage" ):
                return latex(r'\begin{minipage}{%s\textwidth}' % content[9:])
            elif content == "/minipage":
                return latex(r'\end{minipage}')
            elif content.startswith( "/minipage=" ):
                return latex(r'\end{minipage}\begin{minipage}{%s\textwidth}' % content[10:])
            # block
#              m = re.search('^/?(\w*block):?(.*)$', content)
            m = re_block.match(content)
            if m:
                if m.group(0)[0] == "/":
                    return latex(r'\end{%s}' % m.group(1))
                else:
                    return latex(r'\begin{%s}{%s}' % (m.group(1), m.group(2)))
            # others
#              m = re.search('^/?(\w*):?(.*)$', content)
            m = re_env.match(content)
            if m:
                if m.group(0)[0] == "/":
                    return latex(r'\end{%s}' % m.group(1))
                else:
                    return latex(r'\begin{%s}[%s]' % (m.group(1), m.group(2)))

if __name__ == "__main__":
    pf.toJSONFilter(mk_columns)
