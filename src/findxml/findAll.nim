## `findAll` search with attributes

from std/xmltree import XmlNode, attr, findAll, items

using
  node: XmlNode

type
  FindAttr* = tuple
    attr, val: string

func findAll*(node; tagName: string; attrs: openArray[FindAttr];
             caseInsensitive = false): seq[XmlNode] =
  ## Find all tags with given attributes
  ##
  ## querySelector like
  for node in node.findAll(tagName, caseInsensitive):
    for (key, val) in attrs:
      if val == node.attr key:
        result.add node

func findAll*(node; sels: openArray[(string, seq[FindAttr])];
              caseInsensitive = false): seq[XmlNode] =
  ## Find all tags with all given attributes
  ##
  ## querySelectorAll like
  result.add node
  for i, (name, attrs) in sels:
    var matched: seq[XmlNode]
    for el in result:
      for x in el.findAll(name, attrs, caseInsensitive):
        matched.add x
    if matched.len == 0:
      break
    result = matched
