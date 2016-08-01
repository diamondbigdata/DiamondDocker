#!/bin/bash
IMGNAME=redis
IMGVERSION=3.2.1
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

