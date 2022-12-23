# Set the width and height of the output image
$width = 100
$height = 100

# Create a blank image to draw on
$image = New-Object System.Drawing.Bitmap($width, $height)

# Set the maximum number of iterations to use when determining if a point is in the set
$maxIterations = 100

# Set the boundaries of the region to display
$xMin = -2
$xMax = 1
$yMin = -1
$yMax = 1

# Initialize the progress bar
$current = 0
$total = $width * $height
Write-Progress -Activity "Drawing Mandelbrot set" -PercentComplete ($current / $total * 100)

# Iterate over each pixel in the image
for ($y = 0; $y -lt $height; $y++)
{
  for ($x = 0; $x -lt $width; $x++)
  {
    # Calculate the complex number corresponding to the current pixel
    $c = [System.Numerics.Complex]::new(
      ($x / $width) * ($xMax - $xMin) + $xMin,
      ($y / $height) * ($yMax - $yMin) + $yMin
    )

    # Set the initial value of z to 0
    $z = [System.Numerics.Complex]::Zero

    # Iterate until we either escape the set or reach the maximum number of iterations
    $i = 0
    while ($i -lt $maxIterations -and $z.Magnitude -le 2)
    {
      $z = $z * $z + $c
      $i++
    }

    # Determine the color to use for the current pixel based on whether it is in the set
    if ($i -eq $maxIterations)
    {
      # The point is not in the set, so color it black
      $color = [System.Drawing.Color]::Black
    }
    else
    {
      # The point is in the set, so create a blue and green color based on the number of iterations required to escape
      $color = [System.Drawing.Color]::FromArgb(50, $i % 200, 50)
    }

    # Set the pixel color in the image
    $image.SetPixel($x, $y, $color)

    # Update the progress bar
    $current++
    Write-Progress -Activity "Drawing Mandelbrot set" -PercentComplete ($current / $total * 100)
  }
}

# Display the image
$image.Save("mandelbrot.png")
