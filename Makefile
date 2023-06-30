CC=/usr/bin/clang
CXX=/usr/bin/clang++

# SOURCES = $(wildcard *.m)
SOURCES = Gnutello.m MyObject.m Othello.m PdfOut.m Stack.m Stroke.m Tree.m TreeNode.m
OBJECTS = $(SOURCES:.m=.o)
MAIN = Gnutello
WHERE = Gnutello.app
PLIST = GnutelloInfo.plist

CFLAGS = $(shell gnustep-config --objc-flags 2>/dev/null) -g -fno-objc-arc
LDFLAGS = -Wl,--no-as-needed -lgnustep-base -lobjc -lm pdfgen.o

GUI_SOURCES = GuiMain.m GnuController.m GnuView.m GnuWindow.m
GUI_OBJECTS = $(GUI_SOURCES:.m=.o)


MAIN = Minimax
WHERE = Minimax.app
PLIST = MinimaxInfo.plist

CFLAGS = $(shell gnustep-config --objc-flags 2>/dev/null) -g
LDFLAGS = -Wl,--no-as-needed -lgnustep-base -lgnustep-gui -lobjc -lm pdfgen.o

$(info $$SOURCES is [${SOURCES}])
$(info $$OBJECTS is [${OBJECTS}])

all: $(OBJECTS) pdfgen main pack

$(OBJECTS): %.o : %.m
	$(CC) $(CFLAGS) -c $< -o $@

$(GUI_OBJECTS): %.o : %.m
	$(CC) $(CFLAGS) -c $< -o $@

main:$(OBJECTS)
	$(CC) -o $(MAIN) $(LDFLAGS) $(OBJECTS)

gui:$(GUI_OBJECTS) pdfgen
	$(CC) -o GuiMain $(LDFLAGS) $(GUI_OBJECTS)


run: clean $(OBJECTS) pdfgen main pack
	./Gnutello
	pdf2svg ./minimax.pdf minimax.svg
	

pack: main
	mkdir -p $(WHERE)
	mkdir -p $(WHERE)/Resources
	cp -v $(MAIN) $(WHERE)
#	cp -v $(PLIST) $(WHERE)/Resources/Info-gnustep.plist

indent:
	uncrustify -c uncobjc.cfg --replace *.m || true
	uncrustify -c uncobjc.cfg --replace *.h || true
	rm *~

notrace:
	sed -i 's/NSLog/\/\/NSLog/g' *.m *.h

traces:
	sed -i 's/\/\/NSLog/NSLog/g' *.m *.h


pdfgen:
	$(CC) -c -o pdfgen.o pdfgen.c

pdftest: pdfgen
	$(CC) -o pdftest pdftest.c pdfgen.o

stacktest:
	$(CC) $(CFLAGS) -o StackTest $(LDFLAGS) StackTest.m

strokestest:
	$(CC) $(CFLAGS) -o StrokesTest $(LDFLAGS) StrokesTest.m Othello.o PdfOut.o Stack.o Stroke.o Tree.o TreeNode.o

minimaxtest:
	$(CC) $(CFLAGS) -o MinimaxTest $(LDFLAGS) MinimaxTest.m Othello.o PdfOut.o Stack.o Stroke.o Tree.o TreeNode.o
	
treetest:$(OBJECTS)
	$(CC) $(CFLAGS) -o TreeTest $(LDFLAGS) TreeTest.m TreeNode.o Stack.o

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(MAIN)
	rm -rf $(WHERE)
