hbbt = {}

function hbbt.toString(data)
    if data ~= nil or data ~= '' then
        if type(data) == 'string' then
            return data
        elseif type(data) == 'boolean' then
            return tostring(data)
        elseif type(data) == 'number' then
            return tostring(data)
        elseif type(data) == 'table' then
            local returnStr = ''
            for _,i in pairs(data) do
                if type(data) == 'string' then
                    returnStr = returnStr..data
                else
                    returnStr = returnStr..hbbt.toString(i)
                end
            end
            return returnStr
        end
    end
end




upSplitter = component.proxy('AC2003BA429F1F4D95F31EB1DA88933B')

print(upSplitter:switchMode(2))

print(hbbt.toString(upSplitter:getAllItems()))

filterItems, index, desc, msg = upSplitter:addOutputFilter('Desc_Cement', 0)
print('Index: '..index..' // Items: '..hbbt.toString(filterItems)..' // Desc: '..desc..' // '..msg)

