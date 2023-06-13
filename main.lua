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
xValues = {40, 80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480, 420, 560, 600, 640, 680, 720}
canvWidth = 800
canvHeight = 544
calculateOnce = false

function love.load()

    love.window.setMode(canvWidth, canvHeight)
    love.graphics.setBackgroundColor(1, 1, 1)

end

function love.draw()

    function calculateX(curLayer, xValues)
        value = xValues[curLayer]
        return value
    end

    function calculateWV(prevLayerV, prevLayerB, nodeNumber)
        value = prevLayerV[nodeNumber] + prevLayerB[nodeNumber]
        return value
    end

    function calculateLV(prevLayerV, prevLayerB, nodeNumber)
        value = prevLayerV[nodeNumber] - prevLayerB[nodeNumber]
        return value
    end

    function calculateWB()
        value = 1
        return value
    end

    function calculateLB(prevLayerB, nodeNumber)
        value = prevLayerB[nodeNumber] * 2
        return value
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

    function createLayer(curLayerV, curLayerB, prevLayerV, prevLayerB, curLayer, xValues, calculateOnce)

        if calculateOnce == false then
            display = ""
            print("Current Layer: " .. tostring((curLayer) - 1))
        end

        for nodeNumber = 1, #prevLayerV do

            if  calculateOnce == false then
                addToTable(curLayerV, curLayerB, prevLayerV, prevLayerB, nodeNumber)
                display = display .. tostring(prevLayerV[nodeNumber]) .. ", "
            end

            drawLine(curLayerV, curLayerB, calculateX(curLayer, xValues), prevLayerV, prevLayerB, (calculateX(curLayer, xValues) - 40), nodeNumber)

        end

        if calculateOnce == false then
            print(display)
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

    calculateOnce = true
    
end
