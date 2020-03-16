class QuadTreeCompressor {
  PImage image;
  QuadTreeCompressor() {
      //System.out.println(System.getProperty("user.dir"));
      image = loadImage("quadtree_original.png");
      
      //normalQuadtreeCompress(image);      
      //channalSeparatedQuadtreeCompress(image);
      //gradientQuadtreeCompress(image);}
  }
  
  color[][] makeColorArray(PImage image) {
    int w = image.width;
    int h = image.height;

    color colors[][] = new color[w][h];

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        //colors[i][j] = new color(image.get(i, j));
        colors[i][j] = image.get(i, j);
      }
    }

    return colors;
  }
  
  
  Vector3DDouble[][] makeGradientArray(PImage image)
  {
    int w = image.width;
    int h = image.height;

    Vector3DDouble colors[][] = new Vector3DDouble[w - 1][h - 1];  

    for (int i = 1; i < w; i++) {
      for (int j = 1; j < h; j++) {
        int color1 = image.get(i, j);
        int color0 = image.get(i - 1, j);
        int colorUp = image.get(i, j - 1);

        int red1 = ColorUtil.red(color1);
        int green1 = ColorUtil.green(color1);
        int blue1 = ColorUtil.blue(color1);

        int red0 = ColorUtil.red(color0);
        int green0 = ColorUtil.green(color0);
        int blue0 = ColorUtil.blue(color0);

        int redUp = ColorUtil.red(colorUp);
        int greenUp = ColorUtil.green(colorUp);
        int blueUp = ColorUtil.blue(colorUp);        

        colors[i-1][j - 1] = new Vector3DDouble((2*red1 - red0 - redUp) / 1.0, (2*green1 - green0 - greenUp)/ 1.0, (2*blue1 - blue0 - blueUp)/ 1.0);
      }
    }

    return colors;
  }
  
  
  int clampColor(double col) {
    if (col < 0)
      return 0;
    if (col > 255)
      return 255;
    else
      return (int) col;
  }
  

  
  PImage makeImage(QuadTree<Vector3DDouble> gradientGrid, PImage firstColumn) {
    PImage image = createImage(gradientGrid.getWidth() + 1, gradientGrid.getHeight() + 1, ARGB);

    //copy first column
    for (int j = 0; j < gradientGrid.getHeight(); j++)
      image.set(0, j, //ColorUtil.greyToRGB(128)
      firstColumn.get(0, j));

    for (int i = 0; i < gradientGrid.getWidth(); i++)
      image.set(i, 0, firstColumn.get(i, 0));

    for (int i = 1; i < gradientGrid.getWidth() + 1; i++)
      for (int j = 1; j < gradientGrid.getHeight() + 1; j++)
      {
        int color0 = image.get(i-1, j);
        int colorUp = image.get(i, j-1);

        int red0 = ColorUtil.red(color0);
        int green0 = ColorUtil.green(color0);
        int blue0 = ColorUtil.blue(color0);

        int redUp = ColorUtil.red(colorUp);
        int greenUp = ColorUtil.green(colorUp);
        int blueUp = ColorUtil.blue(colorUp);    

        int newColor = ColorUtil.rgb(
          clampColor((gradientGrid.get(i-1, j-1).x + red0 + redUp)/2), 
          clampColor((gradientGrid.get(i-1, j-1).y + green0 + greenUp)/2), 
          clampColor((gradientGrid.get(i-1, j-1).z + blue0 + blueUp)/2));

        image.set(i, j, newColor);
      }

    return image;
  }
  

  //@SuppressWarnings("boxing")
  
  double[][] makeChannelArray(PImage image, int channel) {
    int w = image.width;
    int h = image.height;

    double colors[][] = new double[w][h];    

    switch(channel) {
      case RED:
        for (int i = 0; i < w; i++) {
          for (int j = 0; j < h; j++) {
            colors[i][j] = (double) ColorUtil.red(image.get(i, j));
          }
        }
      break;
    case GREEN:
        for (int i = 0; i < w; i++) {
          for (int j = 0; j < h; j++) {
            colors[i][j] = (double) ColorUtil.green(image.get(i, j));
          }
        }
      break;
    case BLUE:
        for (int i = 0; i < w; i++) {
          for (int j = 0; j < h; j++) {
            colors[i][j] = (double) ColorUtil.blue(image.get(i, j));
          }
        }
      break;
    }

    return colors;
  }
  
  
/*
  private void normalQuadtreeCompress(PImage image) {
    color[][] colors = makeColorArray(image);  

    int w = image.width;
    int h = image.height;

    for (int k = 1; k < 20; k++) {
      QuadTree<color> quadTree = new QuadTree<color>(colors, new ImageMeasure(), k / 300.0, color(0, 0, 0));

      PImage outImage = createImage(w, h, ARGB);

      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          outImage.set(i, j, quadTree.get(i, j).get());
        }
      }

      //ImageIO.write(outImage, "png", new File("/Users/julianhespenheide/Documents/Development/Git/jianping/Sketches/Drafts/quadtreeCompression/export/normal_quad" + k + ".png"));
      outImage.save("normal_quad" + k + ".png");
    }
  }
  */

  /*
  private static void channalSeparatedQuadtreeCompress(BufferedImage image) throws IOException {
    Double[][] red = makeChannelArray(image, Channel.RED);
    Double[][] green = makeChannelArray(image, Channel.GREEN);
    Double[][] blue = makeChannelArray(image, Channel.BLUE);

    int width = image.getWidth();
    int height = image.getHeight();

    for (int k = 1; k < 20; k++)
    {
      //QuadTree<Double> redTree = new QuadTree<Double>(red, new ChannelMeasure(), k / 900.0 //new Double(0)
      //);
      //QuadTree<Double> greenTree = new QuadTree<Double>(green, new ChannelMeasure(), k / 900.0 //new Double(0)
      //);
      //QuadTree<Double> blueTree = new QuadTree<Double>(blue, new ChannelMeasure(), k / 900.0 //new Double(0)
      //);
      
      QuadTree<Double> redTree = new QuadTree<Double>(red, new ChannelMeasure(), k / 900.0);
      QuadTree<Double> greenTree = new QuadTree<Double>(green, new ChannelMeasure(), k / 900.0);
      QuadTree<Double> blueTree = new QuadTree<Double>(blue, new ChannelMeasure(), k / 900.0);

      BufferedImage outImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);

      for (int i = 0; i < width; i++)
      {
        for (int j = 0; j < height; j++)
        {
          int rgb = ColorUtil.rgb(
            (int) (double)redTree.get(i, j), 
            (int) (double)greenTree.get(i, j), 
            (int) (double)blueTree.get(i, j));

          outImage.setRGB(i, j, rgb);
        }
      }    

      ImageIO.write(outImage, "png", new File("/Users/julianhespenheide/Documents/Development/Git/jianping/Sketches/Drafts/quadtreeCompression/export/channel_separated_quad" + k + ".png"));
    }
  }

  /*
  private static void gradientQuadtreeCompress(BufferedImage image) throws IOException
  {

    Vector3DDouble[][] gradient = makeGradientArray(image);

    for (int k = 1; k < 20; k++)
    {
      QuadTree<Vector3DDouble> gradientTree = new QuadTree<Vector3DDouble>(gradient, new GradientMeasure(), k / 300.0);

      BufferedImage outImage = makeImage(gradientTree, image);
      ImageIO.write(outImage, "png", new File("/Users/julianhespenheide/Documents/Development/Git/jianping/Sketches/Drafts/quadtreeCompression/export/gradient_quad" + k + ".png"));
    }
  }
  */

  /*
  public static class ChannelMeasure extends AbstractMeasure<Double> {

    @SuppressWarnings("boxing")
      @Override
      public Double approximate(Double[][] data, int x, int y, int width, int height)
    {
      double sum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          sum += data[i][j];
        }
      }

      return sum / (width * height);
    }

    @Override
      public double measureDetail(Double[][] data, int x, int y, int width, int height)
    {
      double average = approximate(data, x, y, width, height);
      double sum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          sum += MathUtil.sqr(average - data[i][j]) / (255*255);
        }
      }

      return sum / (width * height);
    }
  }*/

  /*
  public static class GradientMeasure extends AbstractMeasure<Vector3DDouble> {

    @Override
      public Vector3DDouble approximate(Vector3DDouble[][] data, int x, int y, int width, int height)
    {
      double redSum = 0;
      double greenSum = 0;
      double blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          redSum += data[i][j].x;
          greenSum += data[i][j].y;
          blueSum += data[i][j].z;
        }
      }

      int pixelCount = width * height;

      return new Vector3DDouble(redSum / pixelCount, greenSum / pixelCount, blueSum / pixelCount);
    }

    @Override
      public double measureDetail(Vector3DDouble[][] data, int x, int y, int width, int height)
    {
      int redSum = 0;
      int greenSum = 0;
      int blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          redSum += data[i][j].x;
          greenSum += data[i][j].y;
          blueSum += data[i][j].z;
        }
      }

      double pixelCount = width * height;

      double redAvg = redSum / pixelCount;
      double greenAvg = greenSum / pixelCount;
      double blueAvg = blueSum / pixelCount;

      redSum = 0;
      greenSum = 0;
      blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          double red = data[i][j].x;
          double green = data[i][j].y;
          double blue = data[i][j].z;

          redSum += MathUtil.sqr(red - redAvg);
          greenSum += MathUtil.sqr(green - greenAvg);
          blueSum += MathUtil.sqr(blue - blueAvg);
        }
      }

      return redSum / (pixelCount * 255 * 255) + greenSum / (pixelCount * 255 * 255) + blueSum / (pixelCount * 255 * 255);
    }
  }*/

  /*
  public class ImageMeasure extends AbstractMeasure<color> {

    @Override
      public Color approximate(Color[][] data, int x, int y, int width, int height)
    {
      int redSum = 0;
      int greenSum = 0;
      int blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          redSum += data[i][j].getRed();
          greenSum += data[i][j].getGreen();
          blueSum += data[i][j].getBlue();
        }
      }

      int pixelCount = width * height;

      return new Color(redSum / pixelCount, greenSum / pixelCount, blueSum / pixelCount);
    }

    @Override
      public double measureDetail(Color[][] data, int x, int y, int width, int height)
    {
      int redSum = 0;
      int greenSum = 0;
      int blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          redSum += data[i][j].getRed();
          greenSum += data[i][j].getGreen();
          blueSum += data[i][j].getBlue();
        }
      }

      double pixelCount = width * height;

      double redAvg = redSum / pixelCount;
      double greenAvg = greenSum / pixelCount;
      double blueAvg = blueSum / pixelCount;

      redSum = 0;
      greenSum = 0;
      blueSum = 0;

      for (int i = x; i < x + width; i++)
      {
        for (int j = y; j < y + height; j++)
        {
          int red = data[i][j].getRed();
          int green = data[i][j].getGreen();
          int blue = data[i][j].getBlue();

          redSum += MathUtil.sqr(red - redAvg);
          greenSum += MathUtil.sqr(green - greenAvg);
          blueSum += MathUtil.sqr(blue - blueAvg);
        }
      }
      return redSum / (pixelCount * 255 * 255) + greenSum / (pixelCount * 255 * 255) + blueSum / (pixelCount * 255 * 255);
    }
  }*/
  
}
