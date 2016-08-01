#!/bin/bash
IMGNAME=diamond-spark
IMGVERSION=1.6.2-hadoop2.6
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

