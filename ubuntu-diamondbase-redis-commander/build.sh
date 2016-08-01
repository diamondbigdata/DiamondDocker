#!/bin/bash
IMGNAME=redis-commander
IMGVERSION=0.4.2
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

