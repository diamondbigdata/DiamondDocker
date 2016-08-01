#!/bin/bash
IMGNAME=diamond-gateone
IMGVERSION=1.1
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

