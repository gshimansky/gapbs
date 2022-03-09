echo on
set ARCH=x64
set TARGET=Release
set EXEC_PATH=%ARCH%\%TARGET%

where /q gzip || goto :getgzip
where /q wget || goto :getwget

mkdir benchmark\graphs\raw

:download
wget -P benchmark/graphs/raw https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.00.gz || goto :error
wget -P benchmark/graphs/raw https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.01.gz || goto :error
wget -P benchmark/graphs/raw https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.02.gz || goto :error
wget -P benchmark/graphs/raw https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.03.gz || goto :error

wget -P benchmark\graphs\raw https://sparse.tamu.edu/MM/LAW/sk-2005.tar.gz || goto :error

wget -P benchmark\graphs\raw http://www.dis.uniroma1.it/challenge9/data/USA-road-d/USA-road-d.USA.gr.gz || goto :error

:unpack
gzip -dc benchmark\graphs\raw\twitter_rv.net.00.gz benchmark\graphs\raw\twitter_rv.net.01.gz benchmark\graphs\raw\twitter_rv.net.02.gz benchmark\graphs\raw\twitter_rv.net.03.gz > benchmark\graphs\raw\twitter.el  || goto :error
tar -xvzf benchmark\graphs\raw\sk-2005.tar.gz -C benchmark\graphs\raw || goto :error
gzip -dc benchmark\graphs\raw\USA-road-d.USA.gr.gz > benchmark\graphs\raw\USA-road-d.USA.gr || goto :error

:convert
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\twitter.el -b benchmark\graphs\twitter.sg || goto :error
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\sk-2005\sk-2005.mtx -b benchmark\graphs\web.sg || goto :error
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\USA-road-d.USA.gr -b benchmark\graphs\road.sg || goto :error

:convert2
%EXEC_PATH%\converter.exe -g27 -k16 -b benchmark\graphs\kron.sg || goto :error
%EXEC_PATH%\converter.exe -u27 -k16 -b benchmark\graphs\urand.sg || goto :error
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\twitter.el -wb benchmark\graphs\twitter.wsg || goto :error
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\sk-2005\sk-2005.mtx -wb benchmark\graphs\web.wsg || goto :error
%EXEC_PATH%\converter.exe -f benchmark\graphs\raw\USA-road-d.USA.gr -wb benchmark\graphs\road.wsg || goto :error
%EXEC_PATH%\converter.exe -g27 -k16 -wb benchmark\graphs\kron.wsg || goto :error
%EXEC_PATH%\converter.exe -u27 -k16 -wb benchmark\graphs\urand.wsg || goto :error
%EXEC_PATH%\converter.exe -sf benchmark\graphs\raw\twitter.el -b benchmark\graphs\twitterU.sg || goto :error
%EXEC_PATH%\converter.exe -sf benchmark\graphs\raw\sk-2005\sk-2005.mtx -b benchmark\graphs\webU.sg || goto :error
%EXEC_PATH%\converter.exe -sf benchmark\graphs\raw\USA-road-d.USA.gr -b benchmark\graphs\roadU.sg || goto :error

copy /y benchmark\graphs\kron.sg benchmark\graphs\kronU.sg || goto :error
copy /y benchmark\graphs\urand.sg benchmark\graphs\urandU.sg || goto :error

echo Success!

exit /b 0

:getgzip
echo This script uses gzip. You can download gzip for windows from http://gnuwin32.sourceforge.net/packages/gzip.htm.
echo Recommented to download "Complete package, except sources".
echo Place "bin" directory in PATH after that and try again.
exit /b 1

:getwget
echo This script uses wget. You can download wget for windows from https://github.com/webfolderio/wget-windows.
echo Recommented to download "Complete package, except sources".
echo Place "bin" directory in PATH after that and try again.
exit /b 1

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
