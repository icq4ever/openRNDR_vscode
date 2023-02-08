#!/bin/sh

# [ OPENRNDR VSCODE ] : openrndr-vscode-launcher.sh
# description         : this script will help with vscode task for OPENRNDR
# author              : Yi donghoon <icq4ever@gmail.com>
# date                : 20230209
# version             : 0.1

echo "[ OPENRNDR VSCODE ] RUN ${fileBasenameNoExtension}.${fileExtname}"
workspaceFolder=$1
scriptDir=$1"/src/main/kotlin"
fileDirname=$2
fileBasenameNoExtension=$3
fileExtname=$4
file=$5

# for debugging
# echo "WORKSPACE: ${workspaceFolder}"
# echo "SCRIPTDIR : ${scriptDir}"
# echo "${fileDirname} - ${scriptDir}"

# check hierichy from script directory, manipulate then set packageName if file is under n subfolder
packageName=$(echo "$fileDirname" | sed "s|${scriptDir}||g" | sed 's/^\///g' |  sed 's/\//./g')

# for debugging
# echo "T-PKGNAME0 : ${packageName}"
# packageName=$(echo "$packageName" | sed 's/^\///g')
# echo "T-PKGNAME1 : ${packageName}"
# packageName=$(echo "$packageName" | sed 's/\//./g' )

# check hierachy and set command argument
if [ "$packageName" == "" ]; then
	applicationName="${fileBasenameNoExtension}"
	isInSubFolder=0
else 
	applicationName="${packageName}.${fileBasenameNoExtension}"
	isInSubFolder=1
fi

# for debugging
# echo "applicatioName : ${applicationName}" 
# echo "PACKAGE NAME : ${packageName}"

# check if opend file is kotlin file
if [ "$fileExtname" != ".kt" ]; then
	# it's not kt file.
	echo "[ OPENRNDR VSCODE ] !! WRONG FILE FORMAT!! PLEASE RUN WITH OPENRNDR FILE."
else
	if [ ${isInSubFolder} -eq 1 ]; then
		#check import statement from first kotlin file
		#read first line of the code
		scriptLine=$(head -n 1 "${file}")

		# echo "SCRIPT : ${scriptLine}"
		# package statement exists?
		# TODO : what if file moved? package update??
		if [ "$scriptLine" != "package ${packageName}" ]; then
			echo "[ OPENRNDR VSCODE ] UPDATE PACKAGE STATEMENT TO HEAD OF FILE"
			echo -e "package ${packageName}\n$(cat ${file})" > ${file}
			# echo "package statement found"
		fi
	fi
	# full run command for gradlew
	command="gradlew run -Papplication=${applicationName}"
	echo "[ OPENRNDR VSCODE ] ./$command"
	sh $command	
fi