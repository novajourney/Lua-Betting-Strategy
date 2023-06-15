layer0v = {0}
layer0b = {1}
layer1v = {}
layer1b = {}
layer2v = {}
layer2b = {}
layer3v = {}
layer3b = {}
layer4v = {}
layer4b = {}
layer5v = {}
layer5b = {}
layer6v = {}
layer6b = {}
layer7v = {}
layer7b = {}
layer8v = {}
layer8b = {}
layer9v = {}
layer9b = {}
layer10v = {}
layer10b = {}
layer11v = {}
layer11b = {}
layer12v = {}
layer12b = {}
layer13v = {}
layer13b = {}
layer14v = {}
layer14b = {}
layer15v = {}
layer15b = {}
layer16v = {}
layer16b = {}
layer17v = {}
layer17b = {}
xValues = {40, 80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480, 520, 560, 600, 640, 680}
canvWidth = 680
canvHeight = 544
calculateOnce = false

function love.load()

    love.window.setMode(canvWidth, canvHeight)
    love.graphics.setBackgroundColor(1, 1, 1)

end

function love.draw()

    function calculateX(curLayer, xValues)
        return xValues[curLayer]
    end

    function calculateWV(prevLayerV, prevLayerB, nodeNumber)
        return prevLayerV[nodeNumber] + prevLayerB[nodeNumber]
    end

    function calculateLV(prevLayerV, prevLayerB, nodeNumber) 
        return prevLayerV[nodeNumber] - prevLayerB[nodeNumber]
    end

    function calculateWB()
        return 1
    end

    function calculateLB(prevLayerB, nodeNumber)
        return prevLayerB[nodeNumber] * 2
    end

    function addToTable(curLayerV, curLayerB, prevLayerV, prevLayerB, nodeNumber)
        table.insert(curLayerV, (#curLayerV + 1), calculateWV(prevLayerV, prevLayerB, nodeNumber))
        table.insert(curLayerV, (#curLayerV + 1), calculateLV(prevLayerV, prevLayerB, nodeNumber))
        table.insert(curLayerB, (#curLayerB + 1), calculateWB())
        table.insert(curLayerB, (#curLayerB + 1), calculateLB(prevLayerB, nodeNumber))
    end

    function drawLine(curLayerV, curLayerB, curLayerX, prevLayerV, prevLayerB, prevLayerX, nodeNumber)
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(prevLayerX, ((prevLayerV[nodeNumber] - 32) * -1), curLayerX, ((calculateWV(prevLayerV, prevLayerB, nodeNumber) - 32) * -1))
        love.graphics.setColor(0, 0, 1)
        love.graphics.line(prevLayerX, ((prevLayerV[nodeNumber] - 32) * -1), curLayerX, ((calculateLV(prevLayerV, prevLayerB, nodeNumber) - 32) * -1))
    end

    function countValues(searchValue, reqLayer)
        count = 0
        for i = 1, #reqLayer do
            if reqLayer[i] == searchValue then
                count = count + 1
            end
        end
        return count
    end
    
    function addToReturnList(searchValue, reqLayer)
        count = countValues(searchValue, reqLayer)
        return tostring(searchValue) .. " - " .. tostring(count) .. " : " .. tostring((count / #reqLayer) * 100) .. "%"
    end
    
    function searchList(list, searchValue)
        for i = 1, #list do
            if searchValue == list[i] then
                return false
            end
        end
        return true
    end

    function printList(list)

        for i = 1, #list do
            print(list[i])
        end
    
    end

    function addTable(table)
        value = 0
        for i = 1, #table do
            value = table[i] + value
        end
        return value
    end

    function createLayer(curLayerV, curLayerB, prevLayerV, prevLayerB, curLayer, xValues, calculateOnce)

        for nodeNumber = 1, #prevLayerV do

            if  calculateOnce == false then
                addToTable(curLayerV, curLayerB, prevLayerV, prevLayerB, nodeNumber)
            end

            drawLine(curLayerV, curLayerB, calculateX(curLayer, xValues), prevLayerV, prevLayerB, (calculateX(curLayer, xValues) - 40), nodeNumber)

        end

        if calculateOnce == false then

            print("Current Layer: " .. tostring((curLayer) - 1))

            initialList = {}
            returnList = {}
            
            for i = 1, #prevLayerV do
                if i == 1 then
                    table.insert(initialList, prevLayerV[i])
                else
                    if searchList(initialList, prevLayerV[i]) then
                        table.insert(initialList, prevLayerV[i])
                    end
                end
            end

            table.sort(initialList) --Why didn't i know about this! Everything would've been so much easier!


            
            for i = 1, #initialList do
                table.insert(returnList, addToReturnList(initialList[i], prevLayerV))
            end

            printList(returnList)

            negativePercentage = nil
            negativeCount = 0

            for i = 1, #prevLayerV do

                if prevLayerV[i] < 0 then
                    negativeCount = negativeCount + 1
                end

                negativePercentage = negativeCount / #prevLayerV

            end

            print("Negative percentage: " .. tostring(negativePercentage) .. "%" .. " (" .. tostring(negativeCount) .. "/" .. tostring(#prevLayerV) .. ")")
            print("Expected Value: " .. tostring(addTable(prevLayerV)))
            
            print("~") --Just to provide some seperation to make it easier to read.
            print("~")
            print("~")

        end
        
    end

    createLayer(layer1v, layer1b, layer0v, layer0b, 1, xValues, calculateOnce)
    createLayer(layer2v, layer2b, layer1v, layer1b, 2, xValues, calculateOnce)
    createLayer(layer3v, layer3b, layer2v, layer2b, 3, xValues, calculateOnce)
    createLayer(layer4v, layer4b, layer3v, layer3b, 4, xValues, calculateOnce)
    createLayer(layer5v, layer5b, layer4v, layer4b, 5, xValues, calculateOnce)
    createLayer(layer6v, layer6b, layer5v, layer5b, 6, xValues, calculateOnce)
    createLayer(layer7v, layer7b, layer6v, layer6b, 7, xValues, calculateOnce)
    createLayer(layer8v, layer8b, layer7v, layer7b, 8, xValues, calculateOnce)
    createLayer(layer9v, layer9b, layer8v, layer8b, 9, xValues, calculateOnce)
    createLayer(layer10v, layer10b, layer9v, layer9b, 10, xValues, calculateOnce)
    createLayer(layer11v, layer11b, layer10v, layer10b, 11, xValues, calculateOnce)
    createLayer(layer12v, layer12b, layer11v, layer11b, 12, xValues, calculateOnce)
    createLayer(layer13v, layer13b, layer12v, layer12b, 13, xValues, calculateOnce)
    createLayer(layer14v, layer14b, layer13v, layer13b, 14, xValues, calculateOnce)
    createLayer(layer15v, layer15b, layer14v, layer14b, 15, xValues, calculateOnce)
    createLayer(layer16v, layer16b, layer15v, layer15b, 16, xValues, calculateOnce)
    createLayer(layer17v, layer17b, layer16v, layer16b, 17, xValues, calculateOnce)

    love.graphics.setColor(0, 1, 0)
    love.graphics.line(0, 32, 800, 32)

    love.graphics.setColor(0, 0, 0, .125)
    for i = 1, #xValues do
        love.graphics.line(xValues[i], 0, xValues[i], canvHeight)
    end

    calculateOnce = true

end
