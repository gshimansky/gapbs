@echo off
set ARCH=x64
set TARGET=Release
set EXEC_PATH=%ARCH%\%TARGET%

mkdir test\out

%EXEC_PATH%\bfs.exe -g10 -n0 > test\out\generate-g10.out || goto :error
findstr /C:"Graph has 1024 nodes and 10496 undirected edges for degree: 10" test\out\generate-g10.out > NUL && echo PASS Generates g10 || echo FAIL Generates g10

%EXEC_PATH%\bfs.exe -u10 -n0 > test\out\generate-u10.out || goto :error
findstr /C:"Graph has 1024 nodes and 16104 undirected edges for degree: 15" test\out\generate-u10.out > NUL && echo PASS Generates u10 || echo --- FAIL Generates u10

%EXEC_PATH%\bfs.exe -f test\graphs\4.gr -n0 > test\out\load-4.gr.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4.gr.out > NUL && echo PASS Load 4.gr || echo --- FAIL Load 4.gr

%EXEC_PATH%\bfs.exe -f test\graphs\4.el -n0 > test\out\load-4.el.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4.el.out > NUL && echo PASS Load 4.el || echo --- FAIL Load 4.el

%EXEC_PATH%\bfs.exe -f test\graphs\4.wel -n0 > test\out\load-4.wel.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4.wel.out > NUL && echo PASS Load 4.wel || echo --- FAIL Load 4.wel

%EXEC_PATH%\bfs.exe -f test\graphs\4.graph -n0 > test\out\load-4.graph.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4.graph.out > NUL && echo PASS Load 4.graph || echo --- FAIL Load 4.graph

%EXEC_PATH%\bfs.exe -f test\graphs\4w.graph -n0 > test\out\load-4w.graph.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4w.graph.out > NUL && echo PASS Load 4w.graph || echo --- FAIL Load 4w.graph

%EXEC_PATH%\bfs.exe -f test\graphs\4.mtx -n0 > test\out\load-4.mtx.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4.mtx.out > NUL && echo PASS Load 4.mtx || echo --- FAIL Load 4w.mtx

%EXEC_PATH%\bfs.exe -f test\graphs\4w.mtx -n0 > test\out\load-4w.mtx.out || goto :error
findstr /C:"Graph has 14 nodes and 53 directed edges for degree: 3" test\out\load-4w.mtx.out > NUL && echo PASS Load 4w.mtx || echo --- FAIL Load 4w.mtx

:kernel

%EXEC_PATH%\bc.exe -g10 -vn1 > test\out\verify-bc-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-bc-g10.out > NUL && echo PASS Verify bc || echo --- FAIL Verify bc

%EXEC_PATH%\bfs.exe -g10 -vn1 > test\out\verify-bfs-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-bfs-g10.out > NUL && echo PASS Verify bfs || echo --- FAIL Verify bfs

%EXEC_PATH%\cc.exe -g10 -vn1 > test\out\verify-cc-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-cc-g10.out > NUL && echo PASS Verify cc || echo --- FAIL Verify cc

%EXEC_PATH%\cc_sv.exe -g10 -vn1 > test\out\verify-cc_sv-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-cc_sv-g10.out > NUL && echo PASS Verify cc_sv || echo --- FAIL Verify cc_sv

%EXEC_PATH%\pr.exe -g10 -vn1 > test\out\verify-pr-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-pr-g10.out > NUL && echo PASS Verify pr || echo --- FAIL Verify pr

%EXEC_PATH%\pr_spmv.exe -g10 -vn1 > test\out\verify-pr_spmv-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-pr_spmv-g10.out > NUL && echo PASS Verify pr_spmv || echo --- FAIL Verify pr_spmv

%EXEC_PATH%\sssp.exe -g10 -vn1 > test\out\verify-sssp-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-sssp-g10.out > NUL && echo PASS Verify sssp || echo --- FAIL Verify sssp

%EXEC_PATH%\tc.exe -g10 -vn1 > test\out\verify-tc-g10.out || goto :error
findstr /C:"Verification:           PASS" test\out\verify-tc-g10.out > NUL && echo PASS Verify tc || echo --- FAIL Verify tc

exit /b 0

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

