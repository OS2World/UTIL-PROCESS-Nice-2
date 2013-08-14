# GNU Make

#DEBUG     = 0
VERSION   = 006
DIST_DIR  = e:\tmp\nice
HOME_DIR  = e:\dev\projects\nice\v0.06

BIN_FILES = engine\*.exe ps\*.exe exec\*.exe
DLL_FILES = engine\*.dll
DOC_FILES = doc\*
SDK_FILES = engine\nice.h engine\nice.lib sdk\sample* sdk\rxnice.dll

all:
	cd engine & make & cd ..
	cd sdk & make & cd ..
	cd ps & make & cd ..
	cd exec & make & cd ..
	
bin:
	zip -r ..\zip\nice$(VERSION)_src.zip *
	
	-mkdir $(DIST_DIR)
	-mkdir $(DIST_DIR)\bin
	-mkdir $(DIST_DIR)\dll
	-mkdir $(DIST_DIR)\doc
	-mkdir $(DIST_DIR)\sdk
	
	rexxtry tmp='$(BIN_FILES)'; do i = 1 to words( tmp ); copy word( tmp, i ) '$(DIST_DIR)\bin'; end
	rexxtry tmp='$(DLL_FILES)'; do i = 1 to words( tmp ); copy word( tmp, i ) '$(DIST_DIR)\dll'; end
	rexxtry tmp='$(SDK_FILES)'; do i = 1 to words( tmp ); copy word( tmp, i ) '$(DIST_DIR)\sdk'; end
	copy $(DOC_FILES) $(DIST_DIR)\doc /s
		

