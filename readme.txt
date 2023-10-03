請完成一直角三角形(Right-angled triangle)之直角座標轉譯系統(Rendering Engine)。此直角三
角形之座標轉譯系統，將可於 testbench 所提供的直角三角形的三個頂點座標如(x1,y1)、(x2,y2)與
(x3,y3)後，轉譯系統將依序完成涵蓋於直角三角形平面內的所有座標點之輸出。

readme.txt :       Readme file.

testfixture.v :     Test bench includes the definition of clock 
                          period and the file names of test patterns.

triangle.v :         The input and output ports are declared in this file.

input.dat :          The input coordinates (xi, yi) of the triangle are 
                          listed in this file.
               
expect.dat :        The expect results (xo,yo) are recorded in this file.

report_xxx.txt :  This file is used to describe the materials that should 
                          be handed in by each team. The design and related file names, 
                          tool names, related specifications and others are described 
                          in this file.


