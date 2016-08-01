#!/bin/bash
IMGNAME=diamond-mirromaker
IMGVERSION=14.04
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

