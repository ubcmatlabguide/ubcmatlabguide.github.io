%% The Disentropic Guide To Matlab
% *By Matthew Dunham*
%%
% This tutorial covers a number of topics on the Matlab programming
% language and environment, including many advanced features and
% techniques. It has been written for those seeking an intensive crash
% course, but will also appeal to seasoned Matlab programmers who want to 
% quickly learn about many of Matlab's new features, such as the redesigned
% object oriented syntax and functionality. It is primarily example based
% and the code for these examples is embedded directly into the document,
% allowing you to easily try it out for yourself as you work your way
% through the tutorial. It was written using Matlab version 7.6, (2008a),
% however much of what is said also applies to earlier versions.
%%
%%
% <html>
% <style type="text/css">
%       td:hover { background: #cccccc;}
%       </style>
%       <br><br><br>
% </style>
% <table border=5 width=100% height=100% BORDERCOLOR="Black" bgcolor=#e6e6e6>
%  <tr  height = 150px>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/gettingStarted.html'            ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Getting <br>Started                   </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/matrixOperations.html'          ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      The<br>Matrix                         </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/writingFunctions.html'          ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Functions                             </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/flowOfControl.html'             ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Flow<br>of<br>Control                 </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/debugProfileStyle.html'         ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Debugging,<br> Profiling,<br> & Style </FONT></FONT></P></CENTER></A></td>
% </tr>
%  <tr  height = 150px>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/StringsCellsStructsSets.html'   ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Strings, Cells,<br>Structs, & Sets    </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/plotting.html'                  ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Plotting                              </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/symbolic.html'                  ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Symbolic<br>Toolkit                   </FONT></FONT></P></CENTER></A></td>       
%  <td  width = 20%  onClick="document.location.href=    './tutorial/external.html'                  ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Calling<br>External<br>Code           </FONT></FONT></P></CENTER></A></td>
%  <td  width = 20%  onClick="document.location.href=    './tutorial/objectOriented.html'            ;"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Object<br>Oriented<br>Programming     </FONT></FONT></P></CENTER></A></td>
% </tr>
% </table>
% </html>
%%
% Please send any bugs, typos, comments, or suggestions to
% *mdunham@cs.ubc.ca*
%%
% <html>
% <style type="text/css">
%       td:hover { background: #cccccc;}
%       </style>
% </style>
% <table border=5 width=100% height=100% BORDERCOLOR="Black" bgcolor=#e6e6e6>
%  <tr  height = 70px>
%  <td  width = 20%  onClick="document.location.href=    './software/software.html';"><CENTER><P STYLE="background: #e6e6e6"><FONT COLOR="#0000FF"><FONT SIZE=4>      Software                   </FONT></FONT></P></CENTER></A></td>
% </tr>
% </table>
% </html>

