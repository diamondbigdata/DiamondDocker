#!/bin/bash
IMGNAME=diamond-portus
IMGVERSION=2.0
docker build -t localreg:6000/$IMGNAME:$IMGVERSION .

