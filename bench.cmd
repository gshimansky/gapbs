echo on
set ARCH=x64
set TARGET=Release
set EXEC_PATH=%ARCH%\%TARGET%

mkdir benchmark\out

%EXEC_PATH%\bfs -f benchmark\graphs\twitter.sg -n64 > benchmark\out\bfs-twitter.out || goto :error
%EXEC_PATH%\pr -f benchmark\graphs\twitter.sg -i1000 -t1e-4 -n16 > benchmark\out\pr-twitter.out || goto :error
%EXEC_PATH%\cc -f benchmark\graphs\twitter.sg -n16 > benchmark\out\cc-twitter.out || goto :error
%EXEC_PATH%\bc -f benchmark\graphs\twitter.sg -i4 -n16 > benchmark\out\bc-twitter.out || goto :error
%EXEC_PATH%\bfs -f benchmark\graphs\web.sg -n64 > benchmark\out\bfs-web.out || goto :error
%EXEC_PATH%\pr -f benchmark\graphs\web.sg -i1000 -t1e-4 -n16 > benchmark\out\pr-web.out || goto :error
%EXEC_PATH%\cc -f benchmark\graphs\web.sg -n16 > benchmark\out\cc-web.out || goto :error
%EXEC_PATH%\bc -f benchmark\graphs\web.sg -i4 -n16 > benchmark\out\bc-web.out || goto :error
%EXEC_PATH%\bfs -f benchmark\graphs\road.sg -n64 > benchmark\out\bfs-road.out || goto :error
%EXEC_PATH%\pr -f benchmark\graphs\road.sg -i1000 -t1e-4 -n16 > benchmark\out\pr-road.out || goto :error
%EXEC_PATH%\cc -f benchmark\graphs\road.sg -n16 > benchmark\out\cc-road.out || goto :error
%EXEC_PATH%\bc -f benchmark\graphs\road.sg -i4 -n16 > benchmark\out\bc-road.out || goto :error
%EXEC_PATH%\bfs -f benchmark\graphs\kron.sg -n64 > benchmark\out\bfs-kron.out || goto :error
%EXEC_PATH%\pr -f benchmark\graphs\kron.sg -i1000 -t1e-4 -n16 > benchmark\out\pr-kron.out || goto :error
%EXEC_PATH%\cc -f benchmark\graphs\kron.sg -n16 > benchmark\out\cc-kron.out || goto :error
%EXEC_PATH%\bc -f benchmark\graphs\kron.sg -i4 -n16 > benchmark\out\bc-kron.out || goto :error
%EXEC_PATH%\tc -f benchmark\graphs\kronU.sg -n3 > benchmark\out\tc-kron.out || goto :error
%EXEC_PATH%\bfs -f benchmark\graphs\urand.sg -n64 > benchmark\out\bfs-urand.out || goto :error
%EXEC_PATH%\pr -f benchmark\graphs\urand.sg -i1000 -t1e-4 -n16 > benchmark\out\pr-urand.out || goto :error
%EXEC_PATH%\cc -f benchmark\graphs\urand.sg -n16 > benchmark\out\cc-urand.out || goto :error
%EXEC_PATH%\bc -f benchmark\graphs\urand.sg -i4 -n16 > benchmark\out\bc-urand.out || goto :error
%EXEC_PATH%\tc -f benchmark\graphs\urandU.sg -n3 > benchmark\out\tc-urand.out || goto :error
%EXEC_PATH%\sssp -f benchmark\graphs\twitter.wsg -n64 -d2 > benchmark\out\sssp-twitter.out || goto :error
%EXEC_PATH%\sssp -f benchmark\graphs\web.wsg -n64 -d2 > benchmark\out\sssp-web.out || goto :error
%EXEC_PATH%\sssp -f benchmark\graphs\road.wsg -n64 -d50000 > benchmark\out\sssp-road.out || goto :error
%EXEC_PATH%\sssp -f benchmark\graphs\kron.wsg -n64 -d2 > benchmark\out\sssp-kron.out || goto :error
%EXEC_PATH%\sssp -f benchmark\graphs\urand.wsg -n64 -d2 > benchmark\out\sssp-urand.out || goto :error
%EXEC_PATH%\tc -f benchmark\graphs\twitterU.sg -n3 > benchmark\out\tc-twitter.out || goto :error
%EXEC_PATH%\tc -f benchmark\graphs\webU.sg -n3 > benchmark\out\tc-web.out || goto :error
%EXEC_PATH%\tc -f benchmark\graphs\roadU.sg -n3 > benchmark\out\tc-road.out || goto :error

exit /b 0

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

