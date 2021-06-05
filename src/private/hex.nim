# Copyright 2021 Rainbow Asteroids (rainbow@portal2d.xyz)
# MIT/X License (https://mit-license.org/)
import std/math, std/tables, std/unicode

const encode_lut = [
                    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B',
                    'C', 'D', 'E', 'F'
                   ]

const decode_lut = {
                    '0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6,
                    '7': 7, '8': 8, '9': 9, 'A': 10, 'B': 11, 'C': 12, 'D': 13,
                    'E': 14, 'F': 15
                   }.toTable

func toHexString*(n: uint): string =
  var n = n

  while n != 0:
    result.add(encode_lut[n mod 16])
    n = n shr 4

  result.reversed

func decodeHexString*(s: string): uint =
  for idx, c in s.string.reversed.pairs:
    doAssert c in decode_lut
    result += (decode_lut[c] * (16 ^ idx)).uint

when isMainModule:
  import std/random

  assert 4.uint.toHexString == "4"
  assert 16.uint.toHexString == "10"
  assert 255.uint.toHexString == "FF"

  assert "4".decodeHexstring == 4
  assert "10".decodeHexString == 16
  assert "FF".decodeHexString == 255

  randomize()
  let n = rand(10000).uint
  assert n.toHexString.decodeHexString == n
