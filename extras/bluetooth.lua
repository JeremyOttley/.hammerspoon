function bluetooth(power)
    print("Setting bluetooth to " .. power)
    result = hs.execute("blueutil --power " .. power)

    if result.rc ~= 0 then
        print("Unexpected result executing `blueutil`: rc=" .. result.rc .. " type=" .. result.type .. " output=" .. result.output)
    end
end
