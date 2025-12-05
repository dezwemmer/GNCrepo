# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# GNC Software Collection
# Author:   Steven Anderson
# Created:  FEB 2024
# Credit:   Aided Navigation: GPS with High Rate Sensors,
#           Jay A. Farrell
# Brief:    Convert Geodetic coordinates to rectangular (ECEF)
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

import math
import const_wgs84 as const

def DMS2rad(deg,min,sec):


def geodetic2ECEF(latRad, longRad, altMeter):
    # define ellipsoid
    f = 1/const.flatReciprocal
    b = const.radEquator*(1 - f)
    ecc = math.sqrt(f*(2 - f))

    # compute normal radius (RN)
    RN = const.radEquator / math.sqrt(1 - (ecc**2)*math.sin(latRad)**2)
    
    # compute ECEF coordinates
    x = (RN + altMeter)*math.cos(latRad)*math.cos(longRad)
    y = (RN + altMeter)*math.cos(latRad)*math.sin(longRad)
    z = ((RN*(1 - ecc**2) + altMeter)*math.sin(latRad))

    print("Latitude (rad): ",latRad)
    print("Longitude (rad): ",longRad)
    print("Altitude (m): ",altMeter)
    print(">>> In ECEF >>>")
    print(x, ",", y, ",", z)

def main():
    DMS2rad(34,0,0.00174)
    geodetic2ECEF(.5934119541,-2.0478571082,251.702) # rad,rad,m
    # TODO: convert deg/min/sec to rad

if __name__ == "__main__":
    main()