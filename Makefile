# ============================================================
#  Makefile — lab6 ECPG (Embedded SQL) + PostgreSQL (C++)
# ============================================================
#
#  Сборка:    make
#  Запуск:    ./shop
#  Очистка:   make clean
#

PG_CONFIG  ?= pg_config
PG_INCLUDE := $(shell $(PG_CONFIG) --includedir)
PG_LIB     := $(shell $(PG_CONFIG) --libdir)
ECPG       := ecpg

CXX        := g++
CXXFLAGS   := -std=c++17 -Wall -Wextra -I$(PG_INCLUDE)
LDFLAGS    := -L$(PG_LIB) -lecpg

TARGET     := shop
SOURCE_PGC := shop.pgc
SOURCE_CPP := shop.cpp

.PHONY: all clean

all: $(TARGET)

# 1. ECPG: shop.pgc -> shop.cpp
$(SOURCE_CPP): $(SOURCE_PGC)
	$(ECPG) -o $(SOURCE_CPP) $(SOURCE_PGC)

# 2. g++: shop.cpp -> shop
$(TARGET): $(SOURCE_CPP)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SOURCE_CPP) $(LDFLAGS)

clean:
	rm -f $(SOURCE_CPP) $(TARGET)
