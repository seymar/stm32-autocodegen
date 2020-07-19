# stm32-unbloated
Managing projects using STM32CubeIDE has disadvantages:
 - Hard to manage settings, there are workspace settings, project settings, build settings, run settings, debug  configurations. All of which can be different on another computer, user or project and therefore an unpredictable variable in your development process possibly costing valuable time.
 > A project should be an isolated package which works deterministically. Download it, build it and achieve the same result independent of machine, environment etc.

 - The generated code from a STM32Cube config forces you to mix your own code with generated code causing all kinds of problems; accidentally overwritten user code, definitions in wrong header files, everything included in main.h. It is not setup in a way that allows you to extend the generated code in your own way. Generated code also shouldn't be under version management but kept as a separate dependency, which is not impossible.
 > It is better to only use the generated code as a reference and 

 - The HAL driver consists of some nice getting started code but is not flexible and optimized enough to use it in production.
 > The Low Layer library scales better with future needs and is therefore a better option.

# Dependencies
 - STM32CubeMX
 - arm-none-eabi

# Building
The build process is as follows:
1. Code is generated for the STM32Cube configurations in the `boards` folder using `./init.sh`
   Generated dependencies such as _LL_ and _CMSIS_ are copied to the `deps` folder
   Generated linker- and startup scripts are copied to the `build` folder
4. Generated code for each board can be used as example and code can be copied
   to the `inc` and `src` directories as needed. This gives way more flexibility
   in comparison to trying to use the bloated generated code which is very hard
   to modify or use in another way. Also makes sure no user code is overwritten.
5. `make` is used to compile the code into the `build` directory using `arm-none-eabi-gcc`
6. `make flash` is used to flash the code to a device with `st-flash`
7. `make debug` is used to start a GDB server with `st-util` or `openocd`
    The code is recompiled, flashed, and `gdb` is started in tui mode.
    Debug using `arm-none-eabi-gdb` on the command line or use an IDE

Optionally:
8. `make test` performs unit tests from the test folder