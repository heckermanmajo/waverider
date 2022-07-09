# Interfaces 

Since Lua has no real interfaces, we use functions 
that check if a checked instance has needed 
values with the correct types.

Functions then can use the interface check function
to determine if the given input is correct.

The check only need to be done in debug mode, so
we don't suffer a performance loss.

The Typehint can be defined in this file as well and 
allows interface specific type hinting by the ide. 


        --- @class PositionInterface 
        --- @field x number (int)  
        --- @field y number (int)  

        fucntion checkPostionInterface(instance)
            assert instance.x ~= nil
            assert type(instance.x) == "number"
            assert instance.x > -1
            assert instance.y ~= nil
            assert type(instance.y) == "number"
            assert instance.x > -1
            -- check if x and y are integers (floats without floatingpoints really)
            assert int(instance.x) == instance.x
            assert int(instance.y) == instance.y
        end 