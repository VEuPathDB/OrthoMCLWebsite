package org.orthomcl.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class RenderingHelper {

  public static <T extends Renderable> void assignColors(Collection<T> renderables) {
    // always use a fixed seeder, so that the same taxon will always get the same color;
    Random random = new Random(0);
    int step = 255 * 3 / renderables.size() + 1;
    List<String> colors = new ArrayList<>();
    while (colors.size() < renderables.size()) {
      step--;
      if (step == 0)
        break;
      for (int r = 0; r < 256; r += step) {
        for (int g = 0; g < 256; g += step) {
          for (int b = 0; b < 256; b += step) {
            String color = "#" + toHex(r) + toHex(g) + toHex(b);
            colors.add(color);
          }
        }
      }
    }

    Collections.shuffle(colors, random);
    int i = 0;
    for (Renderable renderable : renderables) {
      if (i < colors.size()) {
        renderable.setColor(colors.get(i));
        i++;
      }
    }
  }

  public static String toHex(int c) {
    c = c % 256;
    String hex = Integer.toHexString(c);
    if (hex.length() == 1)
      hex = "0" + hex;
    return hex;
  }

}
