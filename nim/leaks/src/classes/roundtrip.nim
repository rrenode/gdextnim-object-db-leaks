import gdext
import gdext/classes/[gdNode, gdTexture2D, gdResourceLoader]

type VariantRoundTripProbe* {.gdsync.} = ptr object of Node

method ready(self: VariantRoundTripProbe) {.gdsync.} =
  let res = ResourceLoader.load("res://icon.svg")
  var tex = (res as gdref Texture2D)

  for i in 0 ..< 100000:
    let v = variant(tex)
    tex = get(v, gdref Texture2D)

    if (i mod 10000) == 0:
      echo "roundtrip ", i