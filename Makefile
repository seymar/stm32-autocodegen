TARGET = STM32F103_RobotDyn_Black_Pill
BUILD_DIR = build

PF = arm-none-eabi-
CPU = -mcpu=cortex-m3

CC = $(PF)gcc
CFLAGS = -g $(CPU)
DEPS = inc/main.h
OBJ = main.o

%.o: src/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

# The object files depend on the .c files and the build directory
main: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

# Create the build directory
#$(BUILD_DIR):
	#mkdir $@

clean:
	-rm -fR $(BUILID_DIR)
