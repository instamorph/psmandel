# Declare variables for the width and height of the image
$width = 80
$height = 24

# Declare variables for the minimum and maximum values of the real and imaginary axes
$minRe = -2
$maxRe = 1
$minIm = -1
$maxIm = 1

# Declare an array of characters to use for the different colors
$colors = " .,:;i1tf*+-p"

# Iterate over each row of the image
for ($y = 0; $y -lt $height; $y++) {

  # Calculate the imaginary component of the current pixel
  $im = $minIm + ($maxIm - $minIm) * $y / $height

  # Iterate over each column of the image
  for ($x = 0; $x -lt $width; $x++) {

    # Calculate the real component of the current pixel
    $re = $minRe + ($maxRe - $minRe) * $x / $width

    # Initialize variables for the Mandelbrot set calculation
    $zRe = 0
    $zIm = 0
    $cRe = $re
    $cIm = $im
    $escape = $false

    # Iterate up to the maximum number of iterations
    for ($i = 0; $i -lt 100; $i++) {

      # Calculate the real and imaginary components of the next value in the sequence
      $zRe2 = $zRe * $zRe
      $zIm2 = $zIm * $zIm
      $zIm = 2 * $zRe * $zIm + $cIm
      $zRe = $zRe2 - $zIm2 + $cRe

      # Check if the magnitude of the complex number is greater than 2
      if ($zRe2 + $zIm2 -gt 4) {
        $escape = $true
        break
      }
    }

    # Output a character to the console based on whether the complex number escaped or not
    if ($escape) {
      # Calculate the color index based on the number of iterations
      $colorIndex = [int](($i / 100) * ($colors.Length - 1))
      # Output the character at the calculated color index
      Write-Host $colors[$colorIndex] -NoNewline
    } else {
      # Output the first character in the colors array (black)
      Write-Host $colors[0] -NoNewline
    }
  }

  # Move to the next line after finishing a row
  Write-Host ""
}
