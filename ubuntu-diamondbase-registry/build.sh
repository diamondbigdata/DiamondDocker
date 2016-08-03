#!/bin/bash
IMGNAME=diamond-registry
IMGVERSION=2.5.0
docker build -t localreg:6000/$IMGNAME:$IMGVERSION .

