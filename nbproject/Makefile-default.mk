#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=rtc.c adc.c main.c i2c.c lcd.c pwm.c dac.c led.c output.c stateMachine.c var.c event.c keypad.c timer.c serial.c alarm.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/rtc.o ${OBJECTDIR}/adc.o ${OBJECTDIR}/main.o ${OBJECTDIR}/i2c.o ${OBJECTDIR}/lcd.o ${OBJECTDIR}/pwm.o ${OBJECTDIR}/dac.o ${OBJECTDIR}/led.o ${OBJECTDIR}/output.o ${OBJECTDIR}/stateMachine.o ${OBJECTDIR}/var.o ${OBJECTDIR}/event.o ${OBJECTDIR}/keypad.o ${OBJECTDIR}/timer.o ${OBJECTDIR}/serial.o ${OBJECTDIR}/alarm.o
POSSIBLE_DEPFILES=${OBJECTDIR}/rtc.o.d ${OBJECTDIR}/adc.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/i2c.o.d ${OBJECTDIR}/lcd.o.d ${OBJECTDIR}/pwm.o.d ${OBJECTDIR}/dac.o.d ${OBJECTDIR}/led.o.d ${OBJECTDIR}/output.o.d ${OBJECTDIR}/stateMachine.o.d ${OBJECTDIR}/var.o.d ${OBJECTDIR}/event.o.d ${OBJECTDIR}/keypad.o.d ${OBJECTDIR}/timer.o.d ${OBJECTDIR}/serial.o.d ${OBJECTDIR}/alarm.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/rtc.o ${OBJECTDIR}/adc.o ${OBJECTDIR}/main.o ${OBJECTDIR}/i2c.o ${OBJECTDIR}/lcd.o ${OBJECTDIR}/pwm.o ${OBJECTDIR}/dac.o ${OBJECTDIR}/led.o ${OBJECTDIR}/output.o ${OBJECTDIR}/stateMachine.o ${OBJECTDIR}/var.o ${OBJECTDIR}/event.o ${OBJECTDIR}/keypad.o ${OBJECTDIR}/timer.o ${OBJECTDIR}/serial.o ${OBJECTDIR}/alarm.o

# Source Files
SOURCEFILES=rtc.c adc.c main.c i2c.c lcd.c pwm.c dac.c led.c output.c stateMachine.c var.c event.c keypad.c timer.c serial.c alarm.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/rtc.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 rtc.c  -o${OBJECTDIR}/rtc.o
	
${OBJECTDIR}/adc.o: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/adc.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 adc.c  -o${OBJECTDIR}/adc.o
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/main.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 main.c  -o${OBJECTDIR}/main.o
	
${OBJECTDIR}/i2c.o: i2c.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/i2c.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 i2c.c  -o${OBJECTDIR}/i2c.o
	
${OBJECTDIR}/lcd.o: lcd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/lcd.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 lcd.c  -o${OBJECTDIR}/lcd.o
	
${OBJECTDIR}/pwm.o: pwm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/pwm.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 pwm.c  -o${OBJECTDIR}/pwm.o
	
${OBJECTDIR}/dac.o: dac.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/dac.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 dac.c  -o${OBJECTDIR}/dac.o
	
${OBJECTDIR}/led.o: led.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/led.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 led.c  -o${OBJECTDIR}/led.o
	
${OBJECTDIR}/output.o: output.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/output.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 output.c  -o${OBJECTDIR}/output.o
	
${OBJECTDIR}/stateMachine.o: stateMachine.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/stateMachine.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 stateMachine.c  -o${OBJECTDIR}/stateMachine.o
	
${OBJECTDIR}/var.o: var.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/var.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 var.c  -o${OBJECTDIR}/var.o
	
${OBJECTDIR}/event.o: event.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/event.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 event.c  -o${OBJECTDIR}/event.o
	
${OBJECTDIR}/keypad.o: keypad.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/keypad.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 keypad.c  -o${OBJECTDIR}/keypad.o
	
${OBJECTDIR}/timer.o: timer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/timer.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 timer.c  -o${OBJECTDIR}/timer.o
	
${OBJECTDIR}/serial.o: serial.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/serial.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 serial.c  -o${OBJECTDIR}/serial.o
	
${OBJECTDIR}/alarm.o: alarm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/alarm.o 
	${MP_CC} --use-non-free --debug -c -mpic16 -p18f4550 alarm.c  -o${OBJECTDIR}/alarm.o
	
else
${OBJECTDIR}/rtc.o: rtc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/rtc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 rtc.c  -o${OBJECTDIR}/rtc.o
	
${OBJECTDIR}/adc.o: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/adc.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 adc.c  -o${OBJECTDIR}/adc.o
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/main.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 main.c  -o${OBJECTDIR}/main.o
	
${OBJECTDIR}/i2c.o: i2c.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/i2c.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 i2c.c  -o${OBJECTDIR}/i2c.o
	
${OBJECTDIR}/lcd.o: lcd.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/lcd.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 lcd.c  -o${OBJECTDIR}/lcd.o
	
${OBJECTDIR}/pwm.o: pwm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/pwm.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 pwm.c  -o${OBJECTDIR}/pwm.o
	
${OBJECTDIR}/dac.o: dac.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/dac.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 dac.c  -o${OBJECTDIR}/dac.o
	
${OBJECTDIR}/led.o: led.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/led.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 led.c  -o${OBJECTDIR}/led.o
	
${OBJECTDIR}/output.o: output.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/output.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 output.c  -o${OBJECTDIR}/output.o
	
${OBJECTDIR}/stateMachine.o: stateMachine.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/stateMachine.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 stateMachine.c  -o${OBJECTDIR}/stateMachine.o
	
${OBJECTDIR}/var.o: var.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/var.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 var.c  -o${OBJECTDIR}/var.o
	
${OBJECTDIR}/event.o: event.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/event.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 event.c  -o${OBJECTDIR}/event.o
	
${OBJECTDIR}/keypad.o: keypad.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/keypad.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 keypad.c  -o${OBJECTDIR}/keypad.o
	
${OBJECTDIR}/timer.o: timer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/timer.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 timer.c  -o${OBJECTDIR}/timer.o
	
${OBJECTDIR}/serial.o: serial.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/serial.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 serial.c  -o${OBJECTDIR}/serial.o
	
${OBJECTDIR}/alarm.o: alarm.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} "${OBJECTDIR}" 
	${RM} ${OBJECTDIR}/alarm.o 
	${MP_CC} --use-non-free -c -mpic16 -p18f4550 alarm.c  -o${OBJECTDIR}/alarm.o
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} -Wl-c -Wl-m --use-non-free -mpic16 -p18f4550 ${OBJECTFILES_QUOTED_IF_SPACED} -odist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} 
else
dist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} -Wl-c -Wl-m --use-non-free -mpic16 -p18f4550 ${OBJECTFILES_QUOTED_IF_SPACED} -odist/${CND_CONF}/${IMAGE_TYPE}/ProjetoSerial_29_11.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
