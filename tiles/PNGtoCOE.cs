using System.Drawing;
using System.Drawing.Drawing2D;

var folder = args[0];
var size = int.Parse(args[1]);

var files = Directory.EnumerateFiles(folder, "*.png")
                     .Order()
                     .ToDictionary(file => byte.Parse(Path.GetFileName(file)[..2], System.Globalization.NumberStyles.HexNumber));
var lastIndex = files.Keys.Order().Last();

Console.WriteLine("memory_initialization_radix = 16;");
Console.WriteLine("memory_initialization_vector = ");
for (byte i = 0; i <= lastIndex; i++)
{
    if (files.TryGetValue(i, out var fileName))
    {
        using var bitmap = new Bitmap(fileName);
        using var scaledBitmap = bitmap.Resize(size);
        Console.WriteLine($"; {Path.GetFileNameWithoutExtension(fileName)}");
        for (var y = 0; y < size; y++)
        {
            for (var x = 0; x < size; x++)
            {
                var pixel = scaledBitmap.GetPixel(x, y);
                Console.Write($"{(pixel.R >> 4):X}{(pixel.G >> 4):X}{(pixel.B >> 4):X}, ");
            }
            Console.WriteLine();
        }
    }
    else
    {
        Console.WriteLine($"; {i:X02} - *** Reserved ***");
        for (var y = 0; y < size; y++)
        {
            Console.WriteLine(string.Join(", ", Enumerable.Repeat("000", size)));
        }
    }
}
Console.WriteLine(';');

public static class BitmapExtensions
{
    public static Bitmap Resize(this Bitmap imgToResize, int size)
    {
        Bitmap b = new(size, size);
        Graphics g = Graphics.FromImage(b);
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
        g.DrawImage(imgToResize, 0, 0, size, size);
        g.Dispose();
        return b;
    }
}
