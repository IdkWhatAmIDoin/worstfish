# Worstfish makefile wrapper

DETECTED_ARCH := $(shell grep -q "bmi2" /proc/cpuinfo && echo "x86-64-bmi2" || echo "x86-64-modern")

all:
	@mkdir -p bin obj
	@cd src && make -j$$(nproc) build ARCH=$(DETECTED_ARCH)
	@mv -f src/stockfish bin/worstfish
	@mv -f src/*.o obj/ 2>/dev/null || true
	@echo "-------------------------------------------------------"
	@echo "Worstfish has compiled"
	@echo "-------------------------------------------------------"
	@echo "Run in bin/"

clean:
	@cd src && make clean
	@rm -rf bin
	@echo "Cleaned out object junk"

.PHONY: all clean
