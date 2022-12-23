$esc=$([char]27)  # define the ANSI escape code

# function to calculate the Mandelbrot set
function Calculate-Mandelbrot {
  param(
    [double]$c_re,
    [double]$c_im,
    [int]$max_iter
  )

  $z_re = 0
  $z_im = 0
  $iter = 0

  # iterate until the maximum number of iterations is reached
  # or the point escapes the Mandelbrot set
  while (($z_re*$z_re + $z_im*$z_im) -le 4 -and $iter -lt $max_iter) {
    $z_re_new = $z_re*$z_re - $z_im*$z_im + $c_re
    $z_im = 2*$z_re*$z_im + $c_im
    $z_re = $z_re_new
    $iter++
  }

  return $iter
}

# set the size of the Mandelbrot set
$width = 80
$height = 24

# set the limits of the Mandelbrot set
$min_re = -2
$max_re = 1
$min_im = -1
$max_im = 1

# iterate through each pixel in the Mandelbrot set
for ($y = 0; $y -lt $height; $y++) {
  for ($x = 0; $x -lt $width; $x++) {
    # calculate the real and imaginary components of the point
    $c_re = $min_re + $x*($max_re - $min_re)/$width
    $c_im = $max_im - $y*($max_im - $min_im)/$height

    # calculate the number of iterations for the point
    $iter = Calculate-Mandelbrot $c_re $c_im 255

    # set the color of the pixel based on the number of iterations
    $color = $iter % 256
    $field = " "  # set the character to display in the pixel
    Write-Host -NoNewLine "$esc[48;5;${color}m$field$esc[0m"  # write the pixel to the terminal
  }
  Write-Host  # move to a new line after each row
}
