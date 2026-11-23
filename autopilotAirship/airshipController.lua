samplesPerSec = 10 -- constant

currentRotation = 0
distanceX = (velocitySen[1] + velocitySen[2]) / 2 / samplesPerSec
distanceZ = velocitySen[3] / samplesPerSec
currentPosition = {0, 0, 0}
currentPosition[1] += distanceX * math.cos(math.rad(currentRotation))
currentPosition[3] += distanceZ * math.sin(math.rad(currentRotation))
