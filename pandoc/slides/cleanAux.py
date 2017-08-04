#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
from __future__ import division


def matchAux(name):
    auxExt = ['log','aux','bbl','blg','idx','ind','ilg','glo','gls','glg','lof',
              'lot','toc','out','bak','sav','tmp','loa','lom','brf']
    auxReg = ['_temp\\.' , 'ctextemp_', '\\(busy\\)$']

    for ext in auxExt:
        if name.endswith('.'+ext):
            return True
    for reg in auxReg:
        import re
        if re.search(reg,name):
            return True
    return False

def deleteAux(bp="./", R=True):
    print(bp)
    import os
    fs = os.listdir(bp)
    for f in fs:
        path = os.path.join(bp, f)
        if os.path.isdir(path) and R:
            deleteAux(path, R)
        elif  matchAux(f):
            print('delete:', path)
            os.remove(path)

if __name__ == "__main__":
    import os
    import sys
    if len(sys.argv) > 1:
        path = sys.argv[1]
    else:
        path = './'
    print(os.path.abspath(path))
    deleteAux(bp=path)
    # input()
