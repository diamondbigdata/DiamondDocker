#!/bin/bash
IMGNAME=diamond-apache2
IMGVERSION=14.04
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

