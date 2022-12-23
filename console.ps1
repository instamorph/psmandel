# Set the width and height of the output image
$width = 80
$height = 40

# Set the maximum number of iterations to use when determining if a point is in the set
$maxIterations = 100

# Set the boundaries of the region to display
$xMin = -2
$xMax = 2
$yMin = -2
$yMax = 2

# Set the output encoding to utf-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
      # The point is not in the set, so set the background color to black
      [console]::BackgroundColor = [System.ConsoleColor]::Black
      [console]::ForegroundColor = [System.ConsoleColor]::White
      [console]::Write(" ")
    }
    else
    {
      # The point is in the set, so set the background color based on the number of iterations required to escape
      $color = [System.Enum]::GetValues([System.consoleColor])[$i % [System.Enum]::GetValues([System.consoleColor]).Count]
      [console]::BackgroundColor = $color
      [console]::ForegroundColor = [System.consoleColor]::Black
      [console]::Write(" ")
    }
  }

  # Move to the next line after each row of pixels
  [console]::WriteLine()
}
