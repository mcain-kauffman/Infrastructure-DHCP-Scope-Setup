@Echo off

rem one DHCP server:
set kfkcdc06="10.10.2.146"

set ScopeName="Visitors"
set ScopeDesc="VLAN 1000"
set Subnet="192.168.0.0"
set Mask="255.255.255.0"
set RangeStart="192.168.0.10"
set RangeStop="192.168.0.250"
set DefGtwy="192.168.0.1"


rem Connect to server and create scope
call netsh dhcp server %kfkcdc06% add scope %Subnet% %Mask% %ScopeName% %ScopeDesc%
IF %ERRORLEVEL% NEQ 0 GoTo End

rem 2. Connect server and set scop IP range
call netsh dhcp server %kfkcdc06% scope %Subnet% add iprange %RangeStart% %RangeStop%
IF %ERRORLEVEL% NEQ 0 GoTo End

rem 4. Connect to sever and set the value of option code 003 (default gateway)
call netsh dhcp server %kfkcdc06% scope %Subnet% set optionvalue 003 IPADDRESS %DefGtwy%
IF %ERRORLEVEL% NEQ 0 GoTo End

rem 5.  Connect to server set the scope state to active.
call netsh dhcp server %kfkcdc06% scope %Subnet% set state 1


:End


