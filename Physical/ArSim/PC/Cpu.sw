<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.4.4.44?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1" />
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="ServerTask" Source="Server.ServerTask.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="SrvMethod" Source="Server.SrvMethod.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01" Source="Client.Client01.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01a" Source="Client.Client01a.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01b" Source="Client.Client01b.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01c" Source="Client.Client01c.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01d" Source="Client.Client01d.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client01e" Source="Client.Client01e.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client02" Source="Client.Client02.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client02a" Source="Client.Client02a.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client03" Source="Client.Client03.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client03a" Source="Client.Client03a.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client03b" Source="Client.Client03b.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client04" Source="Client.Client04.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Client05" Source="Client.Client05.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="OpcUaMap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsOpcUac" Source="Libraries.AsOpcUac.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsOpcUas" Source="Libraries.AsOpcUas.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asieccon" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>