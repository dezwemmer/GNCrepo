# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# GNC Software Collection
# Author:   Steven Anderson
# Created:  NOV 2025
# Brief:    Simple Kalman Filter in 1D system
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

import numpy as np

class KalmanFilter:
    def __init__(self,dt,processVar, measVar):
        # State (position & velocity)
        self.x = np.array([[0],[0]])

        # Covariance matrix
        self.P = np.eye(2)

        # State transition matrix
        self.F = np.array([[1, dt],
                           [0, 1]])

        # Measurement model
        self.H = np.array([[1, 0]])
        # Note: if we had a measurement of velocity, this would be [[1,0],[0,1]]

        # Process noise covariance
        q = processVar
        self.Q = np.array([[q, 0],
                           [0, q]])

        # Measurement noise covariance
        # Note: Higher R tells the filter the measurements are inaccurate & weights
        #       them less heavily.
        self.R = np.array([[measVar]])

    
    def predict(self):
        # Predict the next state
        self.x = self.F @ self.x

        # Predict the next covariance
        self.P = self.F @ self.P @ np.transpose(self.F) + self.Q
    

    def update(self, z):
        # Input: z is a scalar measurement

        # Compute the innovation (measurement residual)
        y = np.array([z]) - self.H @ self.x

        # Compute innovation covariance
        S = self.H @ self.P @ np.transpose(self.H) + self.R

        # Compute Kalman Gain
        K = self.P @ np.transpose(self.H) @ np.linalg.inv(S)

        # Update state estimate
        self.x = self.x + K @ y

        # Update covariance
        self.P = (np.eye(2) - K @ self.H) @ self.P

    def getState(self):
        return self.x.flatten()


def main():
    kf = KalmanFilter(dt= 1.0, processVar=0.1, measVar=1.1)
    measurements = [1, 2, 3, 4.5, 6, 7.2]

    print("Position", "Velocity")
    for z in measurements:
        kf.predict()
        kf.update(z)
        print('{:<10}{:<10}'.format( f'{kf.getState()[0]:.{3}f}' , f'{kf.getState()[1]:.{3}f}'))

if __name__ == "__main__":
    main()

