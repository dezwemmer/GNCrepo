# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# GNC Software Collection
# Author:   Steven Anderson
# Created:  FEB 2024
# Credit:   Aided Navigation: GPS with High Rate Sensors,
#           Jay A. Farrell
# Brief:    Convert rectangular (ECEF) to Geodetic coordinates
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

import math
import const_wgs84 as const

def ECEF2geodetic(x, y, z):
    # Initialization
    h = 0
    Rn = const.radEquator
    p = math.sqrt(x**2 + y**2)


def main():
    ECEF2geodetic(-2430601.8275718857, -4702442.703207922, 3546587.3581285323) 

if __name__ == "__main__":
    main()