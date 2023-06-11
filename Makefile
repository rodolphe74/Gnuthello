CC=/usr/bin/clang
CXX=/usr/bin/clang++

SOURCES = $(wildcard *.m)
OBJECTS = $(SOURCES:.m=.o)
MAIN = Minimax
WHERE = Minimax.app
PLIST = MinimaxInfo.plist

CFLAGS = $(shell gnustep-config --objc-flags 2>/dev/null) -g
LDFLAGS = -Wl,--no-as-needed -lgnustep-base -lobjc -lm pdfgen.o

$(info $$SOURCES is [${SOURCES}])
$(info $$OBJECTS is [${OBJECTS}])

all: $(OBJECTS) pdfgen main pack

$(OBJECTS): %.o : %.m
	$(CC) $(CFLAGS) -c $< -o $@

main:$($OBJECTS)
	$(CC) -o $(MAIN) $(LDFLAGS) $(OBJECTS)

pack: main
	mkdir -p $(WHERE)
	cp -v $(MAIN) $(WHERE)
	cp -rv Resources $(WHERE)
#	cp -v $(PLIST) $(WHERE)/Resources/Info-gnustep.plist

indent:
	uncrustify -c uncobjc.cfg --replace *.m || true
	uncrustify -c uncobjc.cfg --replace *.h || true


pdfgen:
	$(CC) -c -o pdfgen.o pdfgen.c

pdftest: pdfgen
	$(CC) -o pdftest pdftest.c pdfgen.o

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(MAIN)
	rm -rf $(WHERE)
