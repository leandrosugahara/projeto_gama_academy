#!/bin/bash
cd 10-final_lab/02-pipeline_app/01-delivery_app/spring-web-youtube
mvn package -Dmaven.test.skip -DskipTests -Dmaven.javadoc.skip=true