#/bin/sh

# MacOs
STM32CUBE="java -jar /Applications/STMicroelectronics/STM32CubeMX.app/Contents/MacOS/STM32CubeMX"
# Windows
# EXEC=java -jar ...

BOARD=STM32F103_RobotDyn_Black_Pill
BF=boards/$BOARD
rm -rf $BF
mkdir $BF
GEN=${BF}/.gen

# TODO: Set root=true

echo "
config load boards/${BOARD}.ioc
set tpl_path $(pwd)/ftl/
project path boards
project generate
exit" >> $GEN
eval $STM32CUBE -q $GEN
rm $GEN

# Move the generated drivers
mkdir ./deps/
cp -rf ${BF}/Drivers/* ./deps/
rm -rf ${BF}/Drivers

# Move startup and linker script to build folder
# find ${BF} -name "*.s" -exec mv '{}' './build/' \;
# find ${BF} -name "*.ld" -exec mv '{}' './build/' \;

# Clean up
rm -rf ${BF}/MXTmpFiles \
       ${BF}/.mxproject \
       ${BF}/Makefile \
       ${BF}/*.ioc