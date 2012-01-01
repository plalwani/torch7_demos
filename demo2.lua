#!/usr/bin/env qlua

-- A simple code to take your image from the camera
-- author: Prashant Lalwani

require 'torch'
require 'qt'
require 'xlua'
require 'qtwidget'
require 'qtuiloader'
xrequire('nnx',true)
xrequire('camera',true)

-- setup GUI (external UI file)
widget = qtuiloader.load('demo2.ui')
win1 = qt.QtLuaPainter(widget.frame)

-- takes the image from camera
camera = image.Camera{}

function display()
	a = camera:forward()
	image.display{image = a, win = win1, zoom = 1}
end

function ButtonPressed()	-- a simple function to save the tensor 'a' to picture.png image file
	img = image.save("picture.png", a)
	print("Picture saved")
end

qt.connect(qt.QtLuaListener(widget.pushButton),
           'sigMousePress(int,int,QByteArray,QByteArray,QByteArray)',
           function (...) ButtonPressed() end)	-- connects the button press action to the function ButtonPressed so that it saves the tensor every time button is pressed

-- qt timer declaration
timer = qt.QTimer()
timer.interval = 10
timer.singleShot = true
qt.connect(timer,'timeout()', function() display() timer:start() end)

-- loads the widget
widget.windowTitle = 'Press Click to take your picture'
widget:show()
timer:start()
