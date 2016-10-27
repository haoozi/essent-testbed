TARGET ?= SoloReg
BUILD_DIR = test_run_dir/playground.$(TARGET)


all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET).fir:
	sbt "run-main playground.$(TARGET)Main rebuild"

$(BUILD_DIR)/$(TARGET).h: $(BUILD_DIR)/$(TARGET).fir
	cd essent; sbt "run ../$(BUILD_DIR)/$(TARGET).fir"

$(BUILD_DIR)/$(TARGET): $(BUILD_DIR)/$(TARGET).h csrc/comm_wrapper.h
	g++ -O3 -Icsrc/ -I$(BUILD_DIR) $(BUILD_DIR)/$(TARGET)-harness.cc -o $(BUILD_DIR)/$(TARGET)

.PHONY: run
run: $(BUILD_DIR)/$(TARGET)
	sbt "run-main playground.$(TARGET)Main"

.PHONY: clean
clean:
	rm $(BUILD_DIR)/*
