#!/usr/bin/python

import PIL.Image

f = PIL.Image.open("font-simple.png")

(w,h) = f.size
d = f.getdata()

inventory = "0123456789"

def getRow(x):
    "Return the row as a 12-bit int"
    global d
    value = 0
    mask = 1
    for y in range(12):
        i = w*y + x
        if d[i] == (0,0,0):
            value = value + mask
        mask = mask << 1
    return value

row_data = []

class Chardata:
    def __init__(self, c, x):
        global row_data
        self.char = c
        self.count = 0
        self.offset = len(row_data)
        row = 1;
        while row != 0:
            row = getRow(x)
            row_data.append(row)
            x = x + 1
            self.count = self.count + 1
    def width(self):
        return self.count

charmap = {}
x = 0

for c in inventory:
    charmap[c] = Chardata(c,x)
    x = x + charmap[c].width()

print "#include <stdint.h>"

print "int16_t charOffsets[256] = { "
for i in range(256):
    offset = -1
    if charmap.has_key(chr(i)):
        offset = charmap[chr(i)].offset
    print "\t" + str(offset) + ","

print "};"

print ""

print "uint16_t rowData[{0}] = ".format(len(row_data))+"{"
for d in row_data:
    print "\t{0},".format(d)
print "};"

