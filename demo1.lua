#!/usr/bin/env qlua

-- A simple code to take your image from the camera and to display it on a qt widget
-- author: Prashant Lalwani

-- initializing the packages required to run the code
require 'torch'
require 'qt'
require 'xlua'
require 'qtwidget'
require 'qtuiloader'
xrequire('nnx',true)
xrequire('camera',true)

-- setup GUI (external UI file)
widget = qtuiloader.load('demo1.ui')	-- loads the user interface test1.ui, a ui file can be easily created or modified using qt designer
win1 = qt.QtLuaPainter(widget.frame)	-- initializing the ui's frame in order to display either an image or text 

-- initializing the camera
camera = image.Camera{}

function display()
	a = camera:forward()	-- grabbing the image from the camera
	image.display{image = a, win = win1, zoom = 1}		-- a function to display the image on the ui's frame(win1), where x and y are the offset 
								-- and zoom specifies the zoom level(can be anything greater than 0)
end

timer = qt.QTimer()	--declares a qt timer to loop the above process
timer.interval = 10	-- declares the timer interval as 10 ms
timer.singleShot = true	-- timer declared as a singleshot timer running from 0 to 10 ms
qt.connect(timer,'timeout()', function() display() timer:start() end)	-- connects the timer to function display and and timer:start()

-- loads the widget
widget.windowTitle = 'A simple test widget'	-- declaring the window title
widget:show()	-- displays the ui when running the code
timer:start()	-- starts the timer


-- Note: the first line declares this file as a script so that it can also be run directly by double clicking the file, simply declare a file as a script and change its property(right click and go to properties and to the permissions tab, select checkbox "allow executing file as a program")
