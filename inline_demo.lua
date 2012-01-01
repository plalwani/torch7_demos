
require 'xlua'
xrequire('inline',true)

 f = inline.load [[
    prinf("Hello, from C!\n");
]]
f()