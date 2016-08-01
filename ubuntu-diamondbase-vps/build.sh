#!/bin/bash
IMGNAME=diamond-vps
IMGVERSION=1.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

