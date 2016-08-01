#!/bin/bash
IMGNAME=diamond-apache-drill
IMGVERSION=1.7.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

