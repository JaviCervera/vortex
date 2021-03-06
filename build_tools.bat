@echo off

echo building meshtool...
g++ -std=c++03 -w -s -static -fno-exceptions -fno-rtti -O2 -m32 -o meshtool.data/meshtool.exe src_tools/meshtool.cc src_tools/loadmesh.cc src_tools/savemesh.cc -Lsrc_tools/irrlicht -lirrlicht.win32 -lgdi32

echo building fonttool...
g++ -std=c++03 -s -static -fno-exceptions -fno-rtti -O2 -m32 -o fonttool.data/fonttool.exe src_tools/fonttool.cc

echo done.
pause
