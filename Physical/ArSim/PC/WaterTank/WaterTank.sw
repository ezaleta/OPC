﻿<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.3.4.77 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1" />
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="ColdTank" Source="ApplicationModule.WaterTank.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="HotTank" Source="ApplicationModule.WaterTank.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="watertank" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="submarine" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
</SwConfiguration>