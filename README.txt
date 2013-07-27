[About]
SQLizer is a Tool to Ddemonstrate and test SQL Syntax written for MacOS X, using Objective-C and Cocoa. This project has been started by Dirk Braun released under GNU Public License Version 3 (GPLv3).

[SQLite Bridge]
SQLite has been published under public Domain. Cocoa does not have direct API SQLizer uses its own Implementation for Accessing its SQLite3 Database. I do not recommend using those Classes in your own Project, as there are currently several drawbacks, like using the Command Line Tool instead of the Libraries.

[Building]
SQLizer should build easiest, using Xcode, you can use every Xcode starting with Snow Leopard Developer Tools (see Building with Snow Leopard Paragraph for further informations).

[10.6 Compability/Building with Snow Leopard]
SQLizer is intended to Run on Systems >= 10.6 (Snow Leopard), as it contains the First Objective-C Version with Garage Collection.

I am programming SQLizer mainly on 10.8, but enabled compabilty for 10.6 Xcode.

If you want to use Xcode on 10.6 on there you need to make following in Project Settings in Order to fix some error and warning messages (since Apple also does some Definitions in newer Cocoa Versions, you may not fix al of them, but SQLizer will work anyway):
	* Set Base SDK to 10.6
	* Set Optimization to some level (I recommend "Fastest [-O3]")
	* Activate Garbage Collection (I recommend "Required [-fobj-gc-only]")
	* Also, you may need to reset the DataSource in TableView again to Main Controller
	* You need to copy the signature of "generateArrayOfRows:" in MEUSQLAccess.m to MEUSQLAccess.h (This is a FIXIT for later Revisions).